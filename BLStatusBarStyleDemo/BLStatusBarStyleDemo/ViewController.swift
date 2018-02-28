//
//  ViewController.swift
//  BLStatusBarStyleDemo
//
//  Created by bailun on 2018/2/27.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class ViewController: BLViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func pushBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        presentAlert(message: "是否确定要取消微信的绑定")
//        presentImagePicker()
    }
    
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { [weak self]
            (action: UIAlertAction) -> Void in
            //cancel do nothing

        })
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { [weak self]
            (action: UIAlertAction) -> Void in

        })
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)

        self.present(alertVC, animated: true, completion: nil)
    }
    
    func presentImagePicker() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension UIImagePickerController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

//    open override var childViewControllerForStatusBarStyle: UIViewController? {
//        return nil
//    }
    
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        modalPresentationCapturesStatusBarAppearance = true
//    }
    
}

extension UIAlertController {
    
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
//    open override var modalPresentationCapturesStatusBarAppearance: Bool {
//        set {
//
//        }
//        get {
//            return true
//        }
//    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
    }
    
}
