//
//  FXVersionCheckManager.swift
//  FXChat
//
//  Created by leiming on 2018/2/8.
//  Copyright © 2018年 Bailun. All rights reserved.
//

import Foundation
import ObjectMapper

class FXVersionCheckManager {
    
    static let shared = FXVersionCheckManager()
    private init() {
    }
    
    /// 当前应用的版本
    var currentInstalledVersion: String? = {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }()
    /// 代理
    weak var delegate: FXVersionCheckDelegate?
    /// 调试打印
    lazy var debugEnabled = false
    // 当前App Store版本
    var currentAppStoreVersion: String?
    // 上一次检查的日期
    var lastVersionCheckPerformedOnDate: Date?
    
    /// 配置版本检测
    func configVersionCheck() {
        
    }
    
    
    /// 检测版本
    func checkVersion(checkType: FXVersionCheckType) {
        switch checkType {
        case .immediately:
            performVersionCheck()
        case .daily:
            break
        case .weekly:
            break
        }
    }
    
}

// MARK: - Helpers (Networking)
extension FXVersionCheckManager {
    
    func performVersionCheck() {
        do {
            let url = try appUpdateApiFromString()
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                self?.processResults(withData: data, response: response, error: error)
            }).resume()
        } catch _ {
            postError(.malformedURL)
        }
    }
    
    func processResults(withData data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            postError(.appStoreDataRetrievalFailure(underlyingError: error))
        } else {
            guard let data = data else {
                postError(.appStoreDataRetrievalFailure(underlyingError: nil))
                return
            }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>
                if let jsonDict = jsonDict {
                    guard let jsonString = jsonDict["bodyMessage"] as? String else {
                        return
                    }
                    guard let model = Mapper<FXVersionCheckModel>().map(JSONString: jsonString) else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        self?.printMessage("Decoded JSON results: \(jsonDict)")
                        // Process Results
                        self?.processVersionCheck(with: model)
                    }
                }
            } catch let error as NSError {
                postError(.appStoreJSONParsingFailure(underlyingError: error))
            }
        }
    }
    
    func processVersionCheck(with model: FXVersionCheckModel) {
        guard let currentAppStoreVersion = model.typeVersion else {
            postError(.appStoreVersionArrayFailure)
            return
        }
        self.currentAppStoreVersion = currentAppStoreVersion
        
        guard isAppStoreVersionNewer() else {
            delegate?.versionCheckLatestVersionInstalled()
            postError(.noUpdateAvailable)
            return
        }
        
    }
    
    func appUpdateApiFromString() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "testfxchatapi.fx110.com"
        components.path = "/api/AppUpdateApi"
        
        var items: [URLQueryItem] = [URLQueryItem(name: "DeviceType", value: "IOS")]
        let item = URLQueryItem(name: "DeviceTypeName", value: "")
        items.append(item)
        
        components.queryItems = items
        
        guard let url = components.url, !url.absoluteString.isEmpty else {
            throw FXVersionCheckError.Known.malformedURL
        }
        
        return url
    }
    
}

// MARK: - Helpers (Version)

extension FXVersionCheckManager {
    
    func isAppStoreVersionNewer() -> Bool {
        var newVersionExists = false
        
        if let currentInstalledVersion = currentInstalledVersion,
            let currentAppStoreVersion = currentAppStoreVersion,
            (currentInstalledVersion.compare(currentAppStoreVersion, options: .numeric) == .orderedAscending) {
            
            newVersionExists = true
        }
        
        return newVersionExists
    }
    
    func storeVersionCheckDate() {
        lastVersionCheckPerformedOnDate = Date()
        if let lastVersionCheckPerformedOnDate = lastVersionCheckPerformedOnDate {
            UserDefaults.standard.set(lastVersionCheckPerformedOnDate, forKey: FXVersionCheckDefaults.StoredVersionCheckDate.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}

// MARK: - Helpers (Misc.)
extension FXVersionCheckManager {
    
    /// Routes a console-bound message to the `SirenLog` struct, which decorates the log message.
    ///
    /// - Parameter message: The message to decorate and log to the console.
    func printMessage(_ message: String) {
        if debugEnabled {
            FXVersionCheckLog(message)
        }
    }
    
}

// MARK: - Enumerated Types (Public)
extension FXVersionCheckManager {
    
    /// Determines the type of alert to present after a successful version check has been performed.
    enum FXAlertType {
        /// Forces user to update your app (1 button alert).
        case force
        /// (DEFAULT) Presents user with option to update app now or at next launch (2 button alert).
        case option
        /// Presents user with option to update the app now, at next launch, or to skip this version all together (3 button alert).
        case skip
        /// Doesn't show the alert, but instead returns a localized message
        /// for use in a custom UI within the sirenDidDetectNewVersionWithoutAlert() delegate method.
        case none
    }
    
    /// Determines the frequency in which the the version check is performed and the user is prompted to update the app.
    ///
    enum FXVersionCheckType: Int {
        /// Version check performed every time the app is launched.
        case immediately = 0
        /// Version check performed once a day.
        case daily = 1
        /// Version check performed once a week.
        case weekly = 7
    }
    
}

// MARK: - Enumerated Types (Private)
extension FXVersionCheckManager {
    
    /// Siren-specific UserDefaults Keys
    enum FXVersionCheckDefaults: String {
        /// Key that stores the timestamp of the last version check in UserDefaults
        case StoredVersionCheckDate
        /// Key that stores the version that a user decided to skip in UserDefaults.
        case StoredSkippedVersion
    }
    
}

// MARK: - Error Handling
extension FXVersionCheckManager {
    
    func postError(_ error: FXVersionCheckError.Known) {
        //        delegate?.sirenDidFailVersionCheck(error: error)
        printMessage(error.localizedDescription)
    }
    
}
