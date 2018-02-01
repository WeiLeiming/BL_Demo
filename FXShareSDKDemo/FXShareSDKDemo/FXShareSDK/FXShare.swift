//
//  FXShare.swift
//  FXShareSDKDemo
//
//  Created by bailun on 2018/1/8.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

typealias FXShareSuccessHandler = ((_ platformType: SSDKPlatformType, _ userData: [AnyHashable: Any]?, _ contentEnity: SSDKContentEntity?, _ error: Error?) -> Void)?
typealias FXShareFailHandler = ((_ platformType: SSDKPlatformType, _ userData: [AnyHashable: Any]?, _ contentEnity: SSDKContentEntity?, _ error: Error?) -> Void)?
typealias FXShareCancelHandler = ((_ platformType: SSDKPlatformType, _ userData: [AnyHashable: Any]?, _ contentEnity: SSDKContentEntity?, _ error: Error?) -> Void)?

class FXShare {
    deinit {
        print("deinit: --> \(type(of: self))")
    }
}

// MARK: - Base Method
extension FXShare {

    /// 通用分享的基方法，闭包回调
    ///
    /// - Parameters:
    ///   - platformType: 平台
    ///   - text: 文本
    ///   - images: 图片集合，传入参数可以为单张图片信息，也可以为一个Array，数组元素可以为UIImage、String（图片路径）、URL（图片路径）
    ///   - url: 链接
    ///   - title: 标题
    ///   - contentType: 分享内容的类型，默认自动检测
    ///   - successHandler: 分享成功回调
    ///   - failHandler: 分享失败回调
    ///   - cancelHandler: 分享取消回调
    public func share(platformType: SSDKPlatformType, text: String?, images: Any?, url: URL?, title: String?, contentType: SSDKContentType = .auto, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        // 1. 创建参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: text,
                                          images: images,
                                          url: url,
                                          title: title,
                                          type: contentType)
        // 2. 进行分享
        ShareSDK.share(platformType, parameters: shareParames) { (state : SSDKResponseState, userData : [AnyHashable : Any]?, contentEntity :SSDKContentEntity?, error : Error?) -> Void in
            switch state {
                case SSDKResponseState.success:
                    successHandler?(platformType, userData, contentEntity, error)
                case SSDKResponseState.fail:
                    failHandler?(platformType, userData, contentEntity, error)
                case SSDKResponseState.cancel:
                    cancelHandler?(platformType, userData, contentEntity, error)
                default:
                    break
            }
        }
    }
    
    /// 通用分享的基方法，使用自带UI菜单，闭包回调
    ///
    /// - Parameters:
    ///   - view: 要显示菜单的视图
    ///   - text: 文本
    ///   - images: 图片集合，传入参数可以为单张图片信息，也可以为一个Array，数组元素可以为UIImage、String（图片路径）、URL（图片路径）
    ///   - url: 链接
    ///   - title: 标题
    ///   - contentType: 分享内容的类型，默认自动检测
    ///   - successHandler: 分享成功回调
    ///   - failHandler: 分享失败回调
    ///   - cancelHandler: 分享取消回调
    public func shareWithUI(referenceView view: UIView?, text: String?, images: Any?, url: URL?, title: String?, contentType: SSDKContentType = .auto, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.simple)
        // 1. 创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: text,
                                          images: images,
                                          url: url,
                                          title: title,
                                          type: contentType)
        // 2. 进行分享
        let sheet = ShareSDK.showShareActionSheet(view, items: nil, shareParams: shareParames) { (state: SSDKResponseState, platformType: SSDKPlatformType, userdata: [AnyHashable : Any]?, contentEnity: SSDKContentEntity?, error: Error?, end) in
            switch state {
                case SSDKResponseState.success:
                    successHandler?(platformType, userdata, contentEnity, error)       // 分享成功
                case SSDKResponseState.fail:
                    failHandler?(platformType, userdata, contentEnity, error)          // 分享失败
                case SSDKResponseState.cancel:
                    cancelHandler?(platformType, userdata, contentEnity, error)        // 分享取消
                default:
                    break
            }
        }
        // 设置新浪微博直接分享，微信和QQ平台默认直接分享
        sheet?.directSharePlatforms.add(SSDKPlatformType.typeSinaWeibo.rawValue)
    }
    
}


// MARK: - Extension Method
extension FXShare {
    
    // MARK: - With UI
    
    public func shareTextWithUI(referenceView view: UIView?, text: String, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        shareWithUI(referenceView: view, text: text, images: nil, url: nil, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
    public func shareImageWithUI(referenceView view: UIView?, images: Any, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        shareWithUI(referenceView: view, text: nil, images: images, url: nil, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
    public func shareURLWithUI(referenceView view: UIView?, url: URL, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        shareWithUI(referenceView: view, text: nil, images: nil, url: url, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
    // MARK: - No UI
    
    public func shareText(platformType: SSDKPlatformType, text: String, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        share(platformType: platformType, text: text, images: nil, url: nil, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
    public func shareImage(platformType: SSDKPlatformType, images: Any, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        share(platformType: platformType, text: nil, images: images, url: nil, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
    public func shareURL(platformType: SSDKPlatformType, url: URL, title: String? = nil, successHandler: FXShareSuccessHandler, failHandler: FXShareFailHandler, cancelHandler: FXShareCancelHandler) {
        share(platformType: platformType, text: nil, images: nil, url: url, title: title, successHandler: { (platformType, userData, contentEnity, error) in
            successHandler?(platformType, userData, contentEnity, error)
        }, failHandler: { (platformType, userData, contentEnity, error) in
            failHandler?(platformType, userData, contentEnity, error)
        }, cancelHandler: { (platformType, userData, contentEnity, error) in
            cancelHandler?(platformType, userData, contentEnity, error)
        })
    }
    
}
