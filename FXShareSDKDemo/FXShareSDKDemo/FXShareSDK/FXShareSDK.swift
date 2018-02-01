//
//  FXShareSDK.swift
//  FXShareSDKDemo
//
//  Created by bailun on 2018/1/9.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation

class FXShareSDK: NSObject {
    
    // MARK: - Properties
    
    /// 分享
    final lazy var share = FXShare()
    /// 第三方登录
    final lazy var thirdLogin = FXThirdLogin()
    
}

// MARK: - Class Method
extension FXShareSDK {

    /// 配置FXShareSDK
    class func setupShareSDK() {
        ShareSDK.registerActivePlatforms([
                SSDKPlatformType.typeSinaWeibo.rawValue,
                SSDKPlatformType.typeQQ.rawValue,
                SSDKPlatformType.subTypeWechatSession.rawValue,
                SSDKPlatformType.subTypeWechatTimeline.rawValue
            ],
             onImport: { (platform: SSDKPlatformType) -> Void in
                switch platform {
                    case SSDKPlatformType.typeQQ:
                        ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                    case SSDKPlatformType.typeWechat:
                        ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    case SSDKPlatformType.typeSinaWeibo:
                        ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                    default:
                        break
                }
            },
             onConfiguration: {(platform: SSDKPlatformType, appInfo: NSMutableDictionary?) -> Void in
                switch platform {
                    case SSDKPlatformType.typeSinaWeibo:
                        // 设置新浪微博应用信息, 其中authType设置为使用SSO＋Web形式授权
                        appInfo?.ssdkSetupSinaWeibo(byAppKey: "3131393775",
                                                    appSecret: "f41b6b26b9b564c06651330e3ed834d8",
                                                    redirectUri: "http://www.fx110.com/thirdlogin/logincallback?type=3",
                                                    authType: SSDKAuthTypeBoth)
                    case SSDKPlatformType.typeWechat:
                        // 设置微信应用信息
                        appInfo?.ssdkSetupWeChat(byAppId: "wx3a931e44ccb64c87",
                                                 appSecret: "70ff108c7a0a84611d7ccf0d195a9085")
                    case SSDKPlatformType.typeQQ:
                        // 设置QQ应用信息
                        // 将AppId转为16进制: echo 'ibase=10;obase=16;1105565353'|bc
                        appInfo?.ssdkSetupQQ(byAppId: "1105565353",
                                             appKey: "I5Q7DWhGVFWZ8P7G",
                                             authType: SSDKAuthTypeBoth)
                    default:
                        break
                }
            })
    }
    
    
    /// 是否安装客户端
    ///
    /// - Parameter platformType: 平台类型
    /// - Returns: true 已安装，false 尚未安装
    func isClientInstalled(platformType: SSDKPlatformType) -> Bool {
        return ShareSDK.isClientInstalled(platformType)
    }
    
}
