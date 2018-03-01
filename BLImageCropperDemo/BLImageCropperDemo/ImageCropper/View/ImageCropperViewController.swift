//
//  ImageCropperImageCropperViewController.swift
//  Mart
//
//  Created by long hua on 01/11/2017.
//  Copyright © 2017 Byran. All rights reserved.
//

import UIKit

let SCALE_FRAME_Y    = 100.0
let BOUNDCE_DURATION = 0.3

class ImageCropperViewController: UIViewController{
    var output: ImageCropperViewOutput!
    var originalImage:UIImage?
    var editedImage:UIImage?
    
    var showImgView: UIImageView!
    var overlayView: UIView?

    var oldFrame: CGRect?
    var largeFrame: CGRect?
    var limitRatio: CGFloat = 5
    
    var latestFrame: CGRect?
    var cropFrame: CGRect!
    
    var tag:NSInteger?
    
   // var delegate:DRImageCropperDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cropFrame = CGRect(x: self.view.center.x - 150, y: self.view.center.y - 150, width: 300, height: 300)
        
        self.initView()
        self.initControlBtn()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ImageCropperViewController: ImageCropperViewInput {
}

// 简化生命周期控制，将模块输入接口配置在View上
extension ImageCropperViewController: ImageCropperModuleInput {
    func setOriginalImage(image:UIImage){
        self.originalImage = image
    }
}

// MARK: 事件处理
extension ImageCropperViewController{
    @objc func doneCrop()  {
        let editImage = self.getSubImage()
        self.output.didCropImage(image: editImage)
    }
    
    // register all gestures
    func addGestureRecognizers() {
        // pinch
        let pinchGestureRecognizer:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchView(_:)))
        self.view.addGestureRecognizer(pinchGestureRecognizer)
        
        // pan
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panView(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // pinch gesture handler
    @objc func pinchView(_ pinchGestureRecognizer:UIPinchGestureRecognizer) {
        let view = self.showImgView!
        if pinchGestureRecognizer.state == UIGestureRecognizerState.began || pinchGestureRecognizer.state == UIGestureRecognizerState.changed {
            view.transform = view.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale)
            pinchGestureRecognizer.scale = 1
        }
        else if pinchGestureRecognizer.state == UIGestureRecognizerState.ended {
            var newFrame = self.showImgView!.frame
            newFrame = self.handleScaleOverflow(newFrame)
            newFrame = self.handleBorderOverflow(newFrame)
            
            UIView.animate(withDuration: BOUNDCE_DURATION, animations: { () -> Void in
                self.showImgView!.frame = newFrame
                self.latestFrame = newFrame
            })
        }
    }
    
    //pan gesture handler
    @objc func panView(_ panGestureRecognizer:UIPanGestureRecognizer) {
        let view = self.showImgView!
        if panGestureRecognizer.state == UIGestureRecognizerState.began || panGestureRecognizer.state == UIGestureRecognizerState.changed {
            let absCenterX = self.cropFrame!.origin.x + self.cropFrame!.size.width / 2
            let absCenterY = self.cropFrame!.origin.y + self.cropFrame!.size.height / 2
            let scaleRatio = self.showImgView!.frame.size.width / self.cropFrame!.size.width
            let acceleratorX = 1 - abs(absCenterX - view.center.x) / (scaleRatio * absCenterX)
            let acceleratorY = 1 - abs(absCenterY - view.center.y) / (scaleRatio * absCenterY)
            let translation = panGestureRecognizer.translation(in: view.superview)
            view.center = CGPoint(x: view.center.x + translation.x * acceleratorX, y: view.center.y + translation.y * acceleratorY)
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.ended {
            var newFrame = self.showImgView!.frame
            newFrame = self.handleBorderOverflow(newFrame)
            UIView.animate(withDuration: BOUNDCE_DURATION, animations: { () -> Void in
                self.showImgView!.frame = newFrame
                self.latestFrame = newFrame
            })
        }
    }

}

// MARK: 视图
extension ImageCropperViewController{
    // initView
    func initView() {
        self.view.backgroundColor = UIColor.black
        self.title = "裁剪"
        
        self.showImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        self.showImgView.isMultipleTouchEnabled   = true
        self.showImgView.isUserInteractionEnabled = true
        self.showImgView.image                    = self.originalImage
        
        // scale to fit the screen
        let oriWidth = self.cropFrame!.size.width
        let oriHeight = (self.originalImage?.size.height)! * (oriWidth / (self.originalImage?.size.width)!)
        let oriX = self.cropFrame.origin.x + (self.cropFrame.size.width - oriWidth) / 2
        let oriY = self.cropFrame.origin.y + ((self.cropFrame.size.height) - oriHeight) / 2
        
        self.oldFrame = CGRect(x: oriX, y: oriY, width: oriWidth, height: oriHeight)
        self.latestFrame = self.oldFrame
        self.showImgView?.frame = self.oldFrame!
        
        self.largeFrame = CGRect(x: 0, y: 0, width: self.limitRatio * self.oldFrame!.size.width, height: self.limitRatio * self.oldFrame!.size.height)
        
        self.addGestureRecognizers()
        self.view.addSubview(self.showImgView!)
        
        self.overlayView = UIView(frame: self.view.bounds)
        self.overlayView?.alpha = 0.5
        self.overlayView?.backgroundColor = UIColor.black
        self.overlayView?.isUserInteractionEnabled = false
        self.overlayView?.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        self.view.addSubview(self.overlayView!)
        
        self.overlayClipping()
    }
    
//--------------------------------
    // FIXME: 修改
    /*
    func initControlBtn() {
        self.setNavItem(title: "完成", action: #selector(doneCrop), position: .navRight)
    }
    */
    
    func initControlBtn() {
        let barButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(completeBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    @objc func completeBtnClicked(sender: UIButton) {
        doneCrop()
    }
//---------------------------------
    
    func overlayClipping() {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        
        // Left side of the ratio view
        path.addRect(CGRect(x: 0, y: 0, width: self.cropFrame.origin.x, height: self.overlayView!.frame.size.height))
        path.addRect(CGRect(
            x: cropFrame.origin.x + self.cropFrame.size.width, y: 0, width: self.overlayView!.frame.size.width - self.cropFrame.origin.x - self.cropFrame.size.width, height: self.overlayView!.frame.size.height))
        
        path.addRect(CGRect(x: 0, y: 0, width: self.overlayView!.frame.size.width, height: cropFrame.origin.y))
        
        path.addRect(CGRect(x: 0, y: self.cropFrame.origin.y + self.cropFrame.size.height, width: self.overlayView!.frame.size.width, height: self.overlayView!.frame.size.height - self.cropFrame.origin.y + self.cropFrame.size.height))
        
        maskLayer.path = path
        self.overlayView?.layer.mask = maskLayer
        path.closeSubpath()
    }
}

// MARK: 私有
extension ImageCropperViewController{
    func handleScaleOverflow(_ newFrame:CGRect) -> CGRect {
        var newFrame = newFrame
        let oriCenter = CGPoint(x: newFrame.origin.x + newFrame.size.width / 2, y: newFrame.origin.y + newFrame.size
            .height / 2)
        if newFrame.size.width < self.oldFrame!.size.width {
            newFrame = self.oldFrame!
        }
        if newFrame.size.width > self.largeFrame!.size.width {
            newFrame = self.largeFrame!
        }
        newFrame.origin.x = oriCenter.x - newFrame.size.width / 2
        newFrame.origin.y = oriCenter.y - newFrame.size.height / 2
        return newFrame
    }
    
    func handleBorderOverflow(_ newFrame:CGRect) -> CGRect {
        var newFrame = newFrame
        if newFrame.origin.x > self.cropFrame!.origin.x {
            newFrame.origin.x = self.cropFrame!.origin.x
        }
        if newFrame.maxX < self.cropFrame!.size.width {
            newFrame.origin.x = self.cropFrame!.size.width - newFrame.size.width
        }
        
        if newFrame.origin.y > self.cropFrame!.origin.y {
            newFrame.origin.y = self.cropFrame!.origin.y
        }
        if newFrame.maxY < self.cropFrame!.origin.y + self.cropFrame!.size.height {
            newFrame.origin.y = self.cropFrame!.origin.y + self.cropFrame!.size.height - newFrame.size.height
        }
        
        if self.showImgView!.frame.size.width > self.showImgView!.frame.size.height && newFrame.size.height <= self.cropFrame!.size.height {
            newFrame.origin.y = self.cropFrame!.origin.y + (self.cropFrame!.size.height - newFrame.size.height) / 2
        }
        return newFrame
    }
    
    /*
    func getSubImage() -> UIImage {
        let squareFrame = self.cropFrame!
        let scaleRatio = self.latestFrame!.size.width / self.originalImage!.size.width
        var x = (squareFrame.origin.x - self.latestFrame!.origin.x) / scaleRatio
        var y = (squareFrame.origin.y - self.latestFrame!.origin.y) / scaleRatio
        var w = squareFrame.size.width / scaleRatio
        var h = squareFrame.size.height / scaleRatio
        if self.latestFrame!.size.width < self.cropFrame!.size.width {
            let newW = self.originalImage!.size.width
            let newH = newW * (self.cropFrame!.size.height / self.cropFrame!.size.width)
            x = 0;
            y = y + (h - newH) / 2
            w = newH
            h = newH
        }
        if self.latestFrame!.size.height < self.cropFrame!.size.height {
            let newH = self.originalImage!.size.height
            let newW = newH * (self.cropFrame!.size.width / self.cropFrame!.size.height)
            x = x + (w - newW) / 2
            y = 0
            w = newH
            h = newH
        }
        
        let myImageRect = CGRect(x: x, y: y, width: w, height: h)
        let imageRef = self.originalImage!.cgImage
        let subImageRef = imageRef?.cropping(to: myImageRect)
        let size:CGSize = CGSize(width: myImageRect.size.width, height: myImageRect.size.height)
        UIGraphicsBeginImageContext(size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.draw(subImageRef!, in: myImageRect)
        let smallImage = UIImage(cgImage: subImageRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
    */
    
//---------------------------------
    // FIXME: 新增
    func getSubImage() -> UIImage {
        print("cropFrame = \(cropFrame!), latestFrame = \(latestFrame!)")
        let squareFrame = self.cropFrame!
        let scaleRatio = self.latestFrame!.size.width / self.originalImage!.size.width
        var x = (squareFrame.origin.x - self.latestFrame!.origin.x) / scaleRatio
        var y = (squareFrame.origin.y - self.latestFrame!.origin.y) / scaleRatio
        var w = squareFrame.size.width / scaleRatio
        var h = squareFrame.size.height / scaleRatio
        if self.latestFrame!.size.width < self.cropFrame!.size.width {
            let newW = self.originalImage!.size.width
            let newH = newW * (self.cropFrame!.size.height / self.cropFrame!.size.width)
            x = 0;
            y = y + (h - newH) / 2
            w = newH
            h = newH
        }
        if self.latestFrame!.size.height < self.cropFrame!.size.height {
            let newH = self.originalImage!.size.height
            let newW = newH * (self.cropFrame!.size.width / self.cropFrame!.size.height)
            x = x + (w - newW) / 2
            y = 0
            w = newH
            h = newH
        }
        
        let myImageRect = CGRect(x: x, y: y, width: w, height: h)
        let imageRef = self.originalImage!.cgImage
        let subImageRef = imageRef?.cropping(to: myImageRect)
        let size:CGSize = CGSize(width: myImageRect.size.width, height: myImageRect.size.height)
        UIGraphicsBeginImageContext(size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.draw(subImageRef!, in: myImageRect)
        let smallImage = UIImage(cgImage: subImageRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
//---------------------------------

}
