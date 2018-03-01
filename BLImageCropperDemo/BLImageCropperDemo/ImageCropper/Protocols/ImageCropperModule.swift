//
//  ImageCropperImageCropperModule.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//

/**
*  methods for communication OuterSide -> ImageCropper
*  define the capabilities of ImageCropper
*/
import UIKit

public protocol ImageCropperModuleInput: class {
    func setOriginalImage(image:UIImage)
}

/**
*  methods for communication ImageCropper -> OuterSide
*  tell the caller what is changed
*/
public protocol ImageCropperModuleOutput: class {
    func didCropImage(cropImage: UIImage)
}

/**
*  default implement of ImageCropperModuleOutput
*  empty implement for optional ops and
*  fatalError make sure required ops
*/
extension ImageCropperModuleOutput {
}
