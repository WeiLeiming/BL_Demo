//
//  ViewController.swift
//  BLTextFiledLimitDemo
//
//  Created by bailun on 2018/2/24.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nickNameTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let limitLength = 10
        let tobeString = textField.text! as NSString
        // 获取高亮部分
        let selectedRange = textField.markedTextRange
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if selectedRange == nil {
            if tobeString.length > limitLength {
                let range = tobeString.rangeOfComposedCharacterSequence(at: limitLength)
                if range.length == 1 {
                    // 单字节输入
                    let newString = tobeString.substring(to: limitLength)
                    textField.text = newString
                } else {
                    // 多字节输入
                    let newRange = tobeString.rangeOfComposedCharacterSequences(for: NSMakeRange(0, range.location))
                    let newString = tobeString.substring(with: newRange)
                    textField.text = newString
                }
            }
        }
    }

}

