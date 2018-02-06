//
//  ViewController.swift
//  Adapt_iPhoneX
//
//  Created by bailun on 2018/2/5.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(self.view.safeAreaInsets)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.view.safeAreaInsets)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self.view.safeAreaInsets)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

