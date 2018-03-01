//
//  ViewController.swift
//  BLImageCropperDemo
//
//  Created by bailun on 2018/2/28.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        openCamera()
    }
    
    @IBAction func photoBtnClicked(_ sender: UIButton) {
        openPhotoAlbum()
    }
    
    func openPhotoAlbum() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    func openCamera(){
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    
    
}

extension ViewController: ImageCropperModuleOutput {
    
    func didCropImage(cropImage: UIImage) {
        print(cropImage)
        previewImageView.image = cropImage
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker.dismiss(animated: true, completion: { [weak self] in
            let (vc, input) = ImageCropperModuleBuilder.setupModule(handler: self)
            self?.navigationController?.pushViewController(vc, animated: true)
            input.setOriginalImage(image: image)
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: UINavigationControllerDelegate {
    
}
