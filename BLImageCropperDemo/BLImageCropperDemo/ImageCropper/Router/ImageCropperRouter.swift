//
//  ImageCropperImageCropperRouter.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//
import UIKit

class ImageCropperRouter{
    weak var transitionHandler : UIViewController!
    weak var presenter: ImageCropperPresenter!
}

extension ImageCropperRouter: ImageCropperRouterInput {
    func didCropImage(image: UIImage){
        presenter.outer?.didCropImage(cropImage: image)
        transitionHandler?.navigationController?.popViewController(animated: true)
    }
}
