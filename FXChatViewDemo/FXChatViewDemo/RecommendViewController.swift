//
//  RecommendViewController.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/17.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.rgbToColor(r: 240, g: 240, b: 243)
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 64))
        navView.backgroundColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
        self.view.addSubview(navView)
        
        
//        let topView = FXChatTopView()
//        topView.setupUI()
//        topView.updateData()
//        self.view.addSubview(topView)
//        topView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(64)
//            make.left.right.equalTo(self.view)
//        }
        
        FXWelcomeView().show()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showWelcomeView(_ sender: UIButton) {
        FXWelcomeView().show()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
