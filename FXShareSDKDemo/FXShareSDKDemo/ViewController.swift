//
//  ViewController.swift
//  FXShareSDKDemo
//
//  Created by bailun on 2018/1/8.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareBtnClicked(_ sender: UIButton) {
//        FXShareSDK().share.shareTextWithUI(referenceView: sender, text: "123", title: "22", successHandler: nil, failHandler: nil) { (type, data, entity, error) in
//            print("分享取消")
//        }
        
//        FXShareSDK().share.shareImageWithUI(referenceView: sender, images: UIImage(named: "shareImg.png"), title: nil, successHandler: { (type, data, entity, err) in
//            print("分享chenggong")
//        }, failHandler: nil, cancelHandler: nil)
        
//        FXShareSDK().share.share(platformType: .typeSinaWeibo, text: "1", images: nil, url: nil, title: nil, successHandler: nil, failHandler: { (type, data, entity, err) in
//            print("分享失败")
//        }) { (type, data, entity, err) in
//            print("分享取消")
//        }
        
        FXShareSDK().share.share(platformType: .subTypeQZone, text: "123", images: "http://b.hiphotos.baidu.com/image/pic/item/58ee3d6d55fbb2fb4a944f8b444a20a44723dcef.jpg", url: nil, title: nil, successHandler: nil, failHandler: nil, cancelHandler: nil)

    }
    
    @IBAction func LoginBtnClicked(_ sender: UIButton) {
        FXShareSDK().thirdLogin.loginBySinaWeibo(successHandler: { (type, user, error) in
            print("登录成功")
        }, failHandler: nil) { (type, user, err) in
            print("登录取消")
        }
    }
    
    
}

