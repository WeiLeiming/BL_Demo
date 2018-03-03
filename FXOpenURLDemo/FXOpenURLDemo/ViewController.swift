//
//  ViewController.swift
//  FXOpenURLDemo
//
//  Created by bailun on 2018/3/2.
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

    @IBAction func leftBtnClicked(_ sender: UIButton) {
        presentAlert(message: "12313546")
    }
    
    @IBAction func rightBtnClicked(_ sender: UIButton) {
        launchAppStore()
    }
    
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
            //cancel do nothing
        })
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { [weak self]
            (action: UIAlertAction) -> Void in
            self?.launchAppStore()
        })
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func launchAppStore() {
        // https://itunes.apple.com/us/app/%e6%b1%87%e4%bf%a1/id1339520994?l=zh&ls=1&mt=8
        // https://itunes.apple.com/app/id376771144
        // 微信：https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8
        // itms-apps:
        guard let url = URL(string: "https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8") else {
            return
        }
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

