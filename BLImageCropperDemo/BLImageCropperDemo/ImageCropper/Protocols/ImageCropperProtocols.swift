//
//  ImageCropperImageCropperProtocols.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//

/**
*  methods for communication PRESENTER -> VIEW

*/
import UIKit
protocol ImageCropperViewInput: class {
}

/**
*  methods for communication VIEW -> PRESENTER
*/
protocol ImageCropperViewOutput {
    func subscribe()
    func unsubscribe()
    func didCropImage(image: UIImage)
}

/**
*  methods for communication PRESENTER -> INTERACTOR
*/
protocol ImageCropperInteractorInput {
    func startObserve()
    func stopObserve()
}

/**
*  methods for communication INTERACTOR -> PRESENTER
*/
protocol ImageCropperInteractorOutput: class {
}

/**
*  methods for communication PRESENTER -> ROUTER
*/
protocol ImageCropperRouterInput {
     func didCropImage(image: UIImage)
}
