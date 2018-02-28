//
//  FXGuideView.swift
//  FXChat
//
//  Created by leiming on 2018/2/27.
//  Copyright © 2018年 Bailun. All rights reserved.
//

import UIKit

class FXGuideView: UIView {
    
    // MARK: - Properties
    
    lazy var guideImageView: UIImageView = {
        let imageView = UIImageView()
//        if UIDevice.iPhoneX() {
            imageView.image = UIImage(named: "welcome_guide_iphonex")//R.image.welcome_guide_iphonex()
//        } else {
//            imageView.image = UIImage(named: "welcome_guide")//R.image.welcome_guide()
//        }
        return imageView
    }()
    
    lazy var finishBtn: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(finishBtnClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension FXGuideView {
    
    func setupSubViews() {
        addSubview(guideImageView)
        addSubview(finishBtn)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        guideImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(33)
            make.centerX.equalTo(guideImageView)
//            make.bottom.equalTo(guideImageView.snp.bottom).offset(-269.5 * UIScreen.main.bounds.size.width / 375)
            make.bottom.equalTo(guideImageView.snp.bottom).offset(-344)
        }
    }
    
}

// MARK: - Show & Hide View
extension FXGuideView {
    
    /// 显示引导视图
    ///
    /// - Parameter superView: 父视图。默认nil，添加欢迎视图至window
    func show(inView superView: UIView? = nil) {
        setupSubViews()
        if superView == nil {
            UIApplication.shared.keyWindow?.addSubview(self)
        } else {
            superView?.addSubview(self)
        }
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    /// 移除欢迎视图
    func dismiss() {
        self.removeFromSuperview()
    }
    
}

// MARK: - Event
extension FXGuideView {
    
    func finishBtnClicked(sender: UIButton) {
        dismiss()
    }
    
}

