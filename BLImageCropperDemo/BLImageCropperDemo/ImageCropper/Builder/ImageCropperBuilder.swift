//
//  ImageCropperImageCropperBuilder.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//

import UIKit

public class ImageCropperModuleBuilder {
    public static func setupModule() -> UIViewController{
        let viewController = self.setupModule(handler: nil).viewController
        return viewController
    }

    public static func setupModule(handler: ImageCropperModuleOutput?) -> (viewController: UIViewController, input: ImageCropperModuleInput){
        let viewController = ImageCropperViewController()
        let input = configure(viewController: viewController, handler: handler)
        return (viewController, input)
    }

    private static func configure(viewController: ImageCropperViewController, handler: ImageCropperModuleOutput?) -> ImageCropperModuleInput {
        let router = ImageCropperRouter()
        router.transitionHandler = viewController

        let presenter = ImageCropperPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.outer = handler
        router.presenter = presenter

        let interactor = ImageCropperInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return viewController
    }
}
