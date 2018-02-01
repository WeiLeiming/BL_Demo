//
//  FXThirdLogin.swift
//  FXShareSDKDemo
//
//  Created by bailun on 2018/1/9.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation

typealias FXThirdLoginSuccessHandler = ((_ platformType: SSDKPlatformType, _ user: SSDKUser?, _ error: Error?) -> Void)?
typealias FXThirdLoginFailHandler = ((_ platformType: SSDKPlatformType, _ user: SSDKUser?, _ error: Error?) -> Void)?
typealias FXThirdLoginCancelHandler = ((_ platformType: SSDKPlatformType, _ user: SSDKUser?, _ error: Error?) -> Void)?

class FXThirdLogin {
    deinit {
        print("deinit: --> \(type(of: self))")
    }
}

// MARK: - Base Method
extension FXThirdLogin {
    
    /// 第三方登录的基方法，闭包回调
    ///
    /// - Parameters:
    ///   - platformType: 授权平台
    ///   - successHandler: 授权成功回调
    ///   - failHandler: 授权失败回调
    ///   - cancelHandler: 授权取消回调
    public func login(platformType: SSDKPlatformType, successHandler: FXThirdLoginSuccessHandler, failHandler: FXThirdLoginFailHandler, cancelHandler: FXThirdLoginCancelHandler) {
        ShareSDK.getUserInfo(platformType, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
            switch state {
                case .success:
                    successHandler?(platformType, user, error)          // 授权成功
                case .fail:
                    failHandler?(platformType, user, error)             // 授权失败
                case .cancel:
                    cancelHandler?(platformType, user, error)           // 授权取消
                default:
                    break
            }
        })
    }
    
    /// 判断分享平台是否授权
    ///
    /// - Parameter platformType: 平台类型
    /// - Returns: true 表示已授权，false 表示尚未授权
    public func hasAuthorized(platformType: SSDKPlatformType) -> Bool {
        return ShareSDK.hasAuthorized(platformType)
    }
    
    /// 取消分享平台授权
    ///
    /// - Parameter platformType: 平台类型
    public func cancelAuthorize(platformType: SSDKPlatformType) {
        ShareSDK.cancelAuthorize(platformType)
    }
    
}


// MARK: - Extension Method
extension FXThirdLogin {

    /// QQ登录
    ///
    /// - Parameters:
    ///   - successHandler: 授权成功回调
    ///   - failHandler: 授权失败回调
    ///   - cancelHandler: 授权取消回调
    public func loginByQQ(successHandler: FXThirdLoginSuccessHandler, failHandler: FXThirdLoginFailHandler, cancelHandler: FXThirdLoginCancelHandler) {
        login(platformType: .typeQQ, successHandler: { (platformType, user, error) in
            successHandler?(platformType, user, error)
        }, failHandler: { (platformType, user, error) in
            failHandler?(platformType, user, error)
        }, cancelHandler: { (platformType, user, error) in
            cancelHandler?(platformType, user, error)
        })
    }
    
    /// 微信登录
    ///
    /// - Parameters:
    ///   - successHandler: 授权成功回调
    ///   - failHandler: 授权失败回调
    ///   - cancelHandler: 授权取消回调
    public func loginByWechat(successHandler: FXThirdLoginSuccessHandler, failHandler: FXThirdLoginFailHandler, cancelHandler: FXThirdLoginCancelHandler) {
        login(platformType: .typeWechat, successHandler: { (platformType, user, error) in
            successHandler?(platformType, user, error)
        }, failHandler: { (platformType, user, error) in
            failHandler?(platformType, user, error)
        }, cancelHandler: { (platformType, user, error) in
            cancelHandler?(platformType, user, error)
        })
    }
    
    /// 微博登录
    ///
    /// - Parameters:
    ///   - successHandler: 授权成功回调
    ///   - failHandler: 授权失败回调
    ///   - cancelHandler: 授权取消回调
    public func loginBySinaWeibo(successHandler: FXThirdLoginSuccessHandler, failHandler: FXThirdLoginFailHandler, cancelHandler: FXThirdLoginCancelHandler) {
        login(platformType: .typeSinaWeibo, successHandler: { (platformType, user, error) in
            successHandler?(platformType, user, error)
        }, failHandler: { (platformType, user, error) in
            failHandler?(platformType, user, error)
        }, cancelHandler: { (platformType, user, error) in
            cancelHandler?(platformType, user, error)
        })
    }
    
}
