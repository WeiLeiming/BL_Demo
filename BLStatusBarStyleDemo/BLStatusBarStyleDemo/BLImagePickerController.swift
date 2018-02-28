//
//  BLImagePickerController.swift
//  BLStatusBarStyleDemo
//
//  Created by bailun on 2018/2/27.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class BLImagePickerController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
