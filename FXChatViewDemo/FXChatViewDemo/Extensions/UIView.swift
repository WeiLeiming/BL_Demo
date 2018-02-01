//
//  UIView.swift
//  FxCommon
//
//  Created by Fang on 2017/7/4.
//  Copyright © 2017年 Byron. All rights reserved.
//

import UIKit

// MARK: animate
extension UIView{
  func shake(_ duration: CFTimeInterval = 0.3){
    let animation = CAKeyframeAnimation()
    animation.keyPath = "position.x"
    animation.values =  [0, 20, -20, 10, 0]
    animation.keyTimes = [0, NSNumber(value: 1 / 6.0), NSNumber(value: 3 / 6.0), NSNumber(value: 5 / 6.0), 1]
    animation.duration = duration
    animation.isAdditive = true
    
    layer.add(animation, forKey:"shake")
  }
  
  func spin(_ duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float){
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.toValue = Double.pi * 2.0 * Double(rotations)
    animation.duration = duration
    animation.isCumulative = true
    animation.repeatCount = repeatCount
    
    layer.add(animation, forKey:"rotationAnimation")
  }
  
    
}

// MARK: - frame
extension UIView {
    
    var fx_top: CGFloat {
        return self.frame.origin.y
    }
    
    var fx_bottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    var fx_left: CGFloat {
        return self.frame.origin.x
    }
    
    var fx_right: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    var fx_width: CGFloat {
        return self.frame.size.width
    }
    
    var fx_height: CGFloat {
        return self.frame.size.height
    }
    
    var fx_size: CGSize{
        return self.frame.size
    }
    
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
}


// MARK: - 屏幕尺寸
let mainScreenWidth  = UIScreen.main.bounds.size.width
let mainScreenHeight = UIScreen.main.bounds.size.height
let mainScreenSize   = UIScreen.main.bounds.size

// MARK: - 为view的边缘加线
extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        
        let border=UIView()
        border.backgroundColor=color
        self.addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(width)
        }
        setNeedsLayout()
        
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border=UIView()
        border.backgroundColor=color
        self.addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(width)
        }
        setNeedsLayout()
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border=UIView()
        border.backgroundColor=color
        self.addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.left.equalTo(self)
            make.height.equalTo(width)
        }
        setNeedsLayout()
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border=UIView()
        border.backgroundColor=color
        self.addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(width)
        }
        setNeedsLayout()
    }

}

