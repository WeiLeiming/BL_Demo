//
//  FXChatQuoteFlashView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/13.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// 外汇文本及指数的左约束
private let foreignLabelLeftConstraint = 10
/// 外汇文本及指数的右约束
private let foreignLabelRightConstraint = -10
/// 三个外汇报价的间隔
private let quoteIntervalWidth = (UIScreen.main.bounds.size.width - 55 - 25 - 0.5 - 0.5) / 3

/// 分割线颜色
private let dividerLineColor = UIColor.rgbToColor(r: 221, g: 221, b: 221)
/// 外汇名称颜色
private let foreignNameColor = UIColor.rgbToColor(r: 33, g: 33, b: 33)
/// 指数上升颜色
private let foreignIndexUpColor = UIColor.rgbToColor(r: 243, g: 86, b: 86)
/// 指数下降颜色
private let foreignIndexDownColor = UIColor.rgbToColor(r: 0, g: 176, b: 124)

/// 更多报价按钮的图片
private let moreQuoteBtnNomalImage = UIImage(named: "backIcon")//R.image.chat_moreQuote()

// MARK: - 输出代理
protocol FXChatQuoteFlashViewDelegate: class {
    func moreQuoteBtnClicked()
    func leftQuoteViewTap(entity: FXChatQuoteFlashEntity)
    func centerQuoteViewTap(entity: FXChatQuoteFlashEntity)
    func rightQuoteViewTap(entity: FXChatQuoteFlashEntity)
}

// MARK: - 单个外汇报价视图
private class SingleQuoteView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fxWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 外汇名称
    let foreignNameLabel = UILabel()
    /// 外汇指数
    let foreignIndexLabel = UILabel()
    
    // MARK: - Setup UI
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // foreignNameLabel
        foreignNameLabel.font = foreignNameLabel.font.withSize(14)
        foreignNameLabel.textColor = foreignNameColor
        foreignNameLabel.textAlignment = .center
        // foreignIndexLabel
        foreignIndexLabel.font = foreignIndexLabel.font.withSize(14)
        foreignIndexLabel.textColor = foreignIndexUpColor
        foreignIndexLabel.textAlignment = .center
        
        // Add SubView
        self.addSubview(foreignNameLabel)
        self.addSubview(foreignIndexLabel)
    }
    
    private func setupConstraints() {
        // foreignNameLabel
        foreignNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self).offset(4)
            make.left.equalTo(self).offset(foreignLabelLeftConstraint)
            make.right.equalTo(self).offset(foreignLabelRightConstraint)
        }
        // foreignIndexLabel
        foreignIndexLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self).offset(22)
            make.bottom.equalTo(self).offset(-2)
            make.left.equalTo(self).offset(foreignLabelLeftConstraint)
            make.right.equalTo(self).offset(foreignLabelRightConstraint)
        }
    }
    
    // MARK: - Update Data
    
    /// 更新数据
    func updateData(entity: FXChatQuoteFlashEntity) {
        foreignNameLabel.text = entity.name
        foreignIndexLabel.text = entity.index
        // TODO: 指数颜色变化
        // 暂时随机显示
        let random = arc4random_uniform(2)
        if random == 1 {
            foreignIndexLabel.textColor = foreignIndexUpColor
        } else {
            foreignIndexLabel.textColor = foreignIndexDownColor
        }
    }
    
}

// MARK: - 报价简讯
class FXChatQuoteFlashView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fxWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 左分割线
    let leftDividerLineView = UIView()
    /// 右分割线
    let rightDividerLineView = UIView()
    /// 左边外汇报价视图
    fileprivate let leftQuoteView = SingleQuoteView()
    /// 中间外汇报价视图
    fileprivate let centerQuoteView = SingleQuoteView()
    /// 右边外汇报价视图
    fileprivate let rightQuoteView = SingleQuoteView()
    /// 更多报价按钮
    let moreQuoteBtn = UIButton()
    
    /// 数据源
    var flashEntity: FXChatFlashEntity?
    /// Delegate
    weak var delegate: FXChatQuoteFlashViewDelegate?
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatQuoteFlashView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // leftDividerLineView
        leftDividerLineView.backgroundColor = dividerLineColor
        // crightDividerLineView
        rightDividerLineView.backgroundColor = dividerLineColor
        // leftQuoteView
        leftQuoteView.setupUI()
        let leftQuoteGesture = UITapGestureRecognizer.init(target: self, action: #selector(FXChatTopView.leftQuoteViewTap(_:)))
        leftQuoteView.addGestureRecognizer(leftQuoteGesture)
        // centerQuoteView
        centerQuoteView.setupUI()
        let centerQuoteGesture = UITapGestureRecognizer.init(target: self, action: #selector(FXChatTopView.centerQuoteViewTap(_:)))
        centerQuoteView.addGestureRecognizer(centerQuoteGesture)
        // rightQuoteView
        rightQuoteView.setupUI()
        let rightQuoteGesture = UITapGestureRecognizer.init(target: self, action: #selector(FXChatTopView.rightQuoteViewTap(_:)))
        rightQuoteView.addGestureRecognizer(rightQuoteGesture)
        // moreQuoteBtn
        moreQuoteBtn.setImage(moreQuoteBtnNomalImage, for: .normal)
        moreQuoteBtn.adjustsImageWhenHighlighted = false
        moreQuoteBtn.addTarget(self, action: #selector(FXChatQuoteFlashView.moreQuoteBtnClicked(_:)), for: .touchUpInside)
        moreQuoteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5.5, 0, 0)
        
        // Add SubView
        self.addSubview(leftDividerLineView)
        self.addSubview(rightDividerLineView)
        self.addSubview(leftQuoteView)
        self.addSubview(centerQuoteView)
        self.addSubview(rightQuoteView)
        self.addSubview(moreQuoteBtn)
    }
    
    private func setupConstraints() {
        // leftDividerLineView
        leftDividerLineView.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(29)
            make.top.equalTo(self).offset(9)
            make.left.equalTo(self).offset(quoteIntervalWidth)
        }
        // centerDividerLineView
        rightDividerLineView.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(29)
            make.top.equalTo(self).offset(9)
            make.left.equalTo(leftDividerLineView).offset(quoteIntervalWidth)
        }
        // leftQuoteView
        leftQuoteView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.right.equalTo(leftDividerLineView.snp.left)
        }
        // centerQuoteView
        centerQuoteView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(leftDividerLineView.snp.right)
            make.right.equalTo(rightDividerLineView.snp.left)
        }
        // rightQuoteView
        rightQuoteView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(rightDividerLineView.snp.right)
            make.right.equalTo(self).offset(-25)
        }
        // moreQuoteBtn
        moreQuoteBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.width.equalTo(26)
            make.height.equalTo(self)
        }
    }
    
}

// MARK: - Event
extension FXChatQuoteFlashView {
    
    func moreQuoteBtnClicked(_ sender: UIButton) {
        self.delegate?.moreQuoteBtnClicked()
    }
    
    func leftQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity else {
            return
        }
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            self.delegate?.leftQuoteViewTap(entity: quoteArr.first!)
        }
    }
    
    func centerQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity else {
            return
        }
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            self.delegate?.centerQuoteViewTap(entity: quoteArr[1])
        }
    }
    
    func rightQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity else {
            return
        }
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            self.delegate?.rightQuoteViewTap(entity: quoteArr.last!)
        }
    }
    
}

// MARK: - Update Data
extension FXChatQuoteFlashView {
    
    /// 更新数据
    func updateData(entity: FXChatFlashEntity) {
        flashEntity = entity
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            leftQuoteView.updateData(entity: quoteArr.first!)
            centerQuoteView.updateData(entity: quoteArr[1])
            rightQuoteView.updateData(entity: quoteArr.last!)
        }
    }
    
}
