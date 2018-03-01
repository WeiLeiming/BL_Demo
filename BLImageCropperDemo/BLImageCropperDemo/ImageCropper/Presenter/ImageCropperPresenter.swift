//
//  ImageCropperImageCropperPresenter.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//

import UIKit
typealias ImageCropperPresenterView = ImageCropperViewOutput
typealias ImageCropperPresenterInteractor = ImageCropperInteractorOutput

class ImageCropperPresenter
{
    weak var view: ImageCropperViewInput!
    var interactor: ImageCropperInteractorInput!
    var router: ImageCropperRouterInput!
    var outer: ImageCropperModuleOutput?
}

extension ImageCropperPresenter: ImageCropperPresenterView{
    func subscribe() {
        interactor.startObserve()
    }

    func unsubscribe() {
        interactor.stopObserve()
    }
    
    func didCropImage(image: UIImage){
        router.didCropImage(image: image)
    }
}

extension ImageCropperPresenter: ImageCropperPresenterInteractor {
}
