//
//  FXChatSimpleTopView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/30.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// 外汇文本及指数的左约束
private let kForeignLabelLeftConstraint = 10
/// 外汇文本及指数的右约束
private let kForeignLabelRightConstraint = -10
/// 三个外汇报价的间隔
private let kQuoteIntervalWidth = UIScreen.main.bounds.size.width / 3

/// 外汇名称颜色
private let kForeignNameColor = UIColor.rgbToColor(r: 3, g: 3, b: 3)
/// 指数上升颜色
private let kForeignIndexUpColor = UIColor.rgbToColor(r: 243, g: 86, b: 86)
/// 指数下降颜色
private let kForeignIndexDownColor = UIColor.rgbToColor(r: 0, g: 176, b: 124)
/// 视图下面的分割线背景颜色
private let kSegmentLineViewBgColor = UIColor.rgbToColor(r: 221, g: 221, b: 221)

// MARK: - 输出代理
protocol FXChatSimpleTopViewOutput: class {
    func onClickQuoteView(entity: FXChatQuoteFlashEntity)
    func onClickMoreQuoteBtn()
    func onClickNewsFlashView(entity: FXChatNewsFlashEntity)
}

// MARK: - 输入
protocol FXChatSimpleTopViewInput {
    func updateData(entity: FXChatFlashEntity)
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
        foreignNameLabel.font = foreignNameLabel.font.withSize(13)
        foreignNameLabel.textColor = kForeignNameColor
        foreignNameLabel.textAlignment = .center
        // foreignIndexLabel
        foreignIndexLabel.font = foreignIndexLabel.font.withSize(13)
        foreignIndexLabel.textColor = kForeignIndexUpColor
        foreignIndexLabel.textAlignment = .center
        
        // Add SubView
        self.addSubview(foreignNameLabel)
        self.addSubview(foreignIndexLabel)
    }
    
    private func setupConstraints() {
        // foreignNameLabel
        foreignNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.centerY.equalTo(self)
            make.width.lessThanOrEqualTo(64.5)
            make.left.greaterThanOrEqualTo(self).offset(kForeignLabelLeftConstraint)
        }
        // foreignIndexLabel
        foreignIndexLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.centerY.equalTo(self)
            make.left.equalTo(foreignNameLabel.snp.right).offset(4)
            make.right.lessThanOrEqualTo(self).offset(kForeignLabelRightConstraint)
        }
    }
    
    // MARK: - Update Data
    
    /// 更新数据
    func updateData(entity: FXChatQuoteFlashEntity) {
        foreignNameLabel.text = entity.name
        foreignIndexLabel.text = entity.index
        // FIXME: 指数颜色变化
        // 暂时随机显示
        let random = arc4random_uniform(2)
        if random == 1 {
            foreignIndexLabel.textColor = kForeignIndexUpColor
        } else {
            foreignIndexLabel.textColor = kForeignIndexDownColor
        }
    }
    
}

typealias FXChatSimpleTopViewDelegate = FXChatSimpleTopViewOutput

// MARK: - 装载单个外汇报价视图
class FXChatSimpleTopView: UIView {
    
    // MARK: - Properties
    
    /// 左边外汇报价视图
    fileprivate let leftQuoteView = SingleQuoteView()
    /// 中间外汇报价视图
    fileprivate let centerQuoteView = SingleQuoteView()
    /// 右边外汇报价视图
    fileprivate let rightQuoteView = SingleQuoteView()
    /// 分割线
    let segmentLineView = UIView()
    
    
    /// 数据源
    var flashEntity: FXChatFlashEntity?
    /// 代理
    weak var delegate: FXChatSimpleTopViewDelegate?

    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fxWhite
        setupUI()
        
        // FIXME: 假数据，待删除
        let quoteEntity1 = FXChatQuoteFlashEntity(quoteID: "1", name: "欧元美元", index: "1.0783")
        let quoteEntity2 = FXChatQuoteFlashEntity(quoteID: "2", name: "欧元匈牙利", index: "1.2484")
        let quoteEntity3 = FXChatQuoteFlashEntity(quoteID: "3", name: "美元指数", index: "99.73")
        let newsEntity = FXChatNewsFlashEntity(newsID: "1", time: "09:41:22", source: "华尔街见闻", content: "央行参事盛松成表示，未来在适当的时候如果情况可以形势需要，我们也可以考虑加息。")
        var entity = FXChatFlashEntity(quoteArray: [], newsArray: [])
        
        entity.quoteArray?.append(quoteEntity1)
        entity.quoteArray?.append(quoteEntity2)
        entity.quoteArray?.append(quoteEntity3)
        for _ in 0..<10 {
            entity.newsArray?.append(newsEntity)
        }
        updateData(entity: entity)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup UI Style & Constraint
extension FXChatSimpleTopView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
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
        // segmentView
        segmentLineView.backgroundColor = kSegmentLineViewBgColor
        
        // Add SubView
        self.addSubview(leftQuoteView)
        self.addSubview(centerQuoteView)
        self.addSubview(rightQuoteView)
        self.addSubview(segmentLineView)
    }
    
    private func setupConstraints() {
        // leftQuoteView
        leftQuoteView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.height.equalTo(34)
            make.width.equalTo(kQuoteIntervalWidth)
        }
        // centerQuoteView
        centerQuoteView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(leftQuoteView.snp.right)
            make.height.equalTo(34)
            make.width.equalTo(kQuoteIntervalWidth)
        }
        // rightQuoteView
        rightQuoteView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.height.equalTo(34)
            make.width.equalTo(kQuoteIntervalWidth)
        }
        // segmentLineView
        segmentLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.bottom.equalTo(self)
        }
    }
    
}

// MARK: - Event
extension FXChatSimpleTopView {
    
    func leftQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity, let quoteArr = entity.quoteArray else {
            return
        }
        if quoteArr.count == 3 {
            self.delegate?.onClickQuoteView(entity: quoteArr.first!)
        }
    }
    
    func centerQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity, let quoteArr = entity.quoteArray else {
            return
        }
        if quoteArr.count == 3 {
            self.delegate?.onClickQuoteView(entity: quoteArr[1])
        }
    }
    
    func rightQuoteViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity, let quoteArr = entity.quoteArray else {
            return
        }
        if quoteArr.count == 3 {
            self.delegate?.onClickQuoteView(entity: quoteArr.last!)
        }
    }
    
}

// MARK: - FXChatSimpleTopViewInput
extension FXChatSimpleTopView: FXChatSimpleTopViewInput {
    
    // 更新数据
    func updateData(entity: FXChatFlashEntity) {
        flashEntity = entity
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            leftQuoteView.updateData(entity: quoteArr.first!)
            centerQuoteView.updateData(entity: quoteArr[1])
            rightQuoteView.updateData(entity: quoteArr.last!)
        }
    }
        
}
