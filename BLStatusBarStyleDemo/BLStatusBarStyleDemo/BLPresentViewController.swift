//
//  BLPresentViewController.swift
//  BLStatusBarStyleDemo
//
//  Created by bailun on 2018/2/27.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class BLPresentViewController: BLViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}
