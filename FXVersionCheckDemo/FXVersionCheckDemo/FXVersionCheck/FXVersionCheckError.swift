//
//  FXVersionCheckError.swift
//  FXVersionCheckDemo
//
//  Created by bailun on 2018/3/1.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation

// MARK: - Error Handling
public struct FXVersionCheckError: LocalizedError {
    
    public enum Known: Error {
        case appStoreAppIDFailure
        case appStoreDataRetrievalFailure(underlyingError: Error?)
        case appStoreJSONParsingFailure(underlyingError: Error)
        case appStoreOSVersionNumberFailure
        case appStoreOSVersionUnsupported
        case appStoreVersionArrayFailure
        case malformedURL
        case noUpdateAvailable
        case recentlyCheckedAlready
        
        var localizedDescription: String {
            switch self {
            case .appStoreAppIDFailure:
                return "Error retrieving trackId as the JSON does not contain a 'trackId' key."
            case .appStoreDataRetrievalFailure(let error?):
                return "Error retrieving App Store data as an error was returned\nAlso, the following system level error was returned: \(error)"
            case .appStoreDataRetrievalFailure(.none):
                return "Error retrieving App Store data as an error was returned."
            case .appStoreJSONParsingFailure(let error):
                return "Error parsing App Store JSON data.\nAlso, the following system level error was returned: \(error)"
            case .appStoreOSVersionNumberFailure:
                return "Error retrieving iOS version number as there was no data returned."
            case .appStoreOSVersionUnsupported:
                return "The version of iOS on the device is lower than that of the one required by the app verison update."
            case .appStoreVersionArrayFailure:
                return "Error retrieving App Store verson number as the JSON does not contain a 'version' key."
            case .malformedURL:
                return "The iTunes URL is malformed. Please leave an issue on http://github.com/ArtSabintsev/Siren with as many details as possible."
            case .noUpdateAvailable:
                return "No new update available."
            case .recentlyCheckedAlready:
                return "Not checking the version, because it already checked recently."
            }
        }
    }
}
