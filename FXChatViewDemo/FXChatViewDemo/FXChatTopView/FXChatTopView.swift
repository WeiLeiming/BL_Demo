//
//  FXChatTopView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/13.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit
import SnapKit

/// 外汇文本及指数的左约束
private let foreignLabelLeftConstraint = 10
/// 外汇文本及指数的右约束
private let foreignLabelRightConstraint = -10
/// 三个外汇报价的间隔
private let quoteIntervalWidth = (UIScreen.main.bounds.size.width - 14 - 0.5 - 0.5) / 3

/// 分割线颜色
private let dividerLineColor = UIColor.rgbToColor(r: 221, g: 221, b: 221)
/// 外汇名称颜色
private let foreignNameColor = UIColor.rgbToColor(r: 33, g: 33, b: 33)
/// 指数上升颜色
private let foreignIndexUpColor = UIColor.rgbToColor(r: 243, g: 86, b: 86)
/// 指数下降颜色
private let foreignIndexDownColor = UIColor.rgbToColor(r: 0, g: 176, b: 124)
/// 新闻时间颜色
private let newsTimeColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
/// 新闻来源颜色
private let newsSourceColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
/// 新闻内容颜色
private let newsContentColor = UIColor.rgbToColor(r: 84, g: 90, b: 100)
/// 视图下面的分割段背景颜色
private let kSegmentViewBgColor = UIColor.rgbToColor(r: 247, g: 247, b: 247)
/// 视图下面的分割线背景颜色
private let kSegmentLineViewBgColor = UIColor.rgbToColor(r: 221, g: 221, b: 221)

/// 更多报价按钮的图片
private let moreQuoteBtnNomalImage = UIImage(named: "homeRight")//R.image.chat_flashMoreQuote()

// MARK: - 输出代理
protocol FXChatTopViewOutput: class {
    func onClickQuoteView(entity: FXChatQuoteFlashEntity)
    func onClickMoreQuoteBtn()
    func onClickNewsFlashView(entity: FXChatNewsFlashEntity)
}

// MARK: - 输入
protocol FXChatTopViewInput {
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
        foreignNameLabel.font = foreignNameLabel.font.withSize(15)
        foreignNameLabel.textColor = foreignNameColor
        foreignNameLabel.textAlignment = .center
        // foreignIndexLabel
        foreignIndexLabel.font = foreignIndexLabel.font.withSize(18)
        foreignIndexLabel.textColor = foreignIndexUpColor
        foreignIndexLabel.textAlignment = .center
        
        // Add SubView
        self.addSubview(foreignNameLabel)
        self.addSubview(foreignIndexLabel)
    }
    
    private func setupConstraints() {
        // foreignNameLabel
        foreignNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(foreignLabelLeftConstraint)
            make.right.equalTo(self).offset(foreignLabelRightConstraint)
        }
        // foreignIndexLabel
        foreignIndexLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.top.equalTo(self).offset(32)
            make.bottom.equalTo(self)
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

// MARK: - 新闻视图
private class NewsFlashView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fxWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 新闻时间
    let newsTimeLabel = UILabel()
    /// 新闻源
    let newsSourceLabel = UILabel()
    /// 新闻内容
    let newsContentLabel = UILabel()
    
    // MARK: - Setup UI
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // newsTimeLabel
        newsTimeLabel.font = newsTimeLabel.font.withSize(15)
        newsTimeLabel.textColor = newsTimeColor
        // newsSourceLabel
        newsSourceLabel.font = newsTimeLabel.font.withSize(12)
        newsSourceLabel.textColor = newsSourceColor
        // newsContentLabel
        newsContentLabel.font = newsTimeLabel.font.withSize(14)
        newsContentLabel.textColor = newsContentColor
        newsContentLabel.numberOfLines = 2
        
        // Add SubView
        self.addSubview(newsTimeLabel)
        self.addSubview(newsSourceLabel)
        self.addSubview(newsContentLabel)
    }
    
    private func setupConstraints() {
        // newsTimeLabel
        newsTimeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.top.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        // newsSourceLabel
        newsSourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(newsTimeLabel)
            make.left.equalTo(newsTimeLabel.snp.right).offset(10)
            make.right.lessThanOrEqualTo(self).offset(-20)
        }
        // newsContentLabel
        newsContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(newsTimeLabel.snp.bottom).offset(4)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-13)
        }
    }
    
    // MARK: - Update Data
    
    /// 更新数据
    func updateData(entity: FXChatNewsFlashEntity) {
        newsTimeLabel.text = entity.time
        newsSourceLabel.text = entity.source
        newsContentLabel.text = entity.content
    }
    
}

typealias FXChatTopViewDelegate = FXChatTopViewOutput

// MARK: - 整体视图，装载其他子视图
class FXChatTopView: UIView {
    
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
    /// 新闻简讯
    fileprivate let newsFlashView = NewsFlashView()
    /// 更多报价按钮
    let moreQuoteBtn = UIButton()
    /// 视图下面的分割段
    let segmentView = UIView()
    let topSegmentLineView = UIView()
    let bottomSegmentLineView = UIView()
    
    /// 数据源
    var flashEntity: FXChatFlashEntity?
    /// 代理
    weak var delegate: FXChatTopViewDelegate?
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatTopView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // leftDividerLineView
        leftDividerLineView.backgroundColor = dividerLineColor
        // rightDividerLineView
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
        // newsFlashView
        newsFlashView.setupUI()
        let newsFlashGesture = UITapGestureRecognizer.init(target: self, action: #selector(FXChatTopView.newsFlashViewTap(_:)))
        newsFlashView.addGestureRecognizer(newsFlashGesture)
        // moreQuoteBtn
        moreQuoteBtn.setImage(moreQuoteBtnNomalImage, for: .normal)
        moreQuoteBtn.adjustsImageWhenHighlighted = false
        moreQuoteBtn.addTarget(self, action: #selector(FXChatTopView.moreQuoteBtnClicked(_:)), for: .touchUpInside)
        moreQuoteBtn.imageEdgeInsets = UIEdgeInsetsMake(9, -15.5, 0, 0)
        // segmentView
        segmentView.backgroundColor = kSegmentViewBgColor
        topSegmentLineView.backgroundColor = kSegmentLineViewBgColor
        bottomSegmentLineView.backgroundColor = kSegmentLineViewBgColor
        
        // Add SubView
        self.addSubview(leftDividerLineView)
        self.addSubview(rightDividerLineView)
        self.addSubview(leftQuoteView)
        self.addSubview(centerQuoteView)
        self.addSubview(rightQuoteView)
        self.addSubview(newsFlashView)
        self.addSubview(moreQuoteBtn)
        self.addSubview(segmentView)
        self.addSubview(topSegmentLineView)
        self.addSubview(bottomSegmentLineView)
    }
    
    private func setupConstraints() {
        // leftDividerLineView
        leftDividerLineView.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(37.5)
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(quoteIntervalWidth)
        }
        // centerDividerLineView
        rightDividerLineView.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(37.5)
            make.top.equalTo(self).offset(15)
            make.left.equalTo(leftDividerLineView).offset(quoteIntervalWidth)
        }
        // leftQuoteView
        leftQuoteView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.right.equalTo(leftDividerLineView.snp.left)
        }
        // centerQuoteView
        centerQuoteView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(leftDividerLineView.snp.right)
            make.right.equalTo(rightDividerLineView.snp.left)
        }
        // rightQuoteView
        rightQuoteView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(rightDividerLineView.snp.right)
            make.right.equalTo(self).offset(-14)
        }
        // newsFlashView
        newsFlashView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(65)
            make.left.right.equalTo(self)
        }
        // moreQuoteBtn
        moreQuoteBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.width.equalTo(26)
            make.height.equalTo(rightQuoteView.snp.height)
        }
        // segmentView
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(newsFlashView.snp.bottom)
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(10)
        }
        topSegmentLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.equalTo(self)
            make.top.equalTo(segmentView)
        }
        bottomSegmentLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.equalTo(self)
            make.bottom.equalTo(segmentView)
        }
    }
    
}

// MARK: - Event
extension FXChatTopView {
    
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
    
    func moreQuoteBtnClicked(_ sender: UIButton) {
        self.delegate?.onClickMoreQuoteBtn()
    }
    
    func newsFlashViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity, let newsArr = entity.newsArray else {
            return
        }
        if newsArr.count > 0 {
            self.delegate?.onClickNewsFlashView(entity: newsArr.first!)
        }
    }
    
}

// MARK: - FXChatTopViewInput
extension FXChatTopView: FXChatTopViewInput {
    
    // 更新数据
    func updateData(entity: FXChatFlashEntity) {
        flashEntity = entity
        if let quoteArr = entity.quoteArray, quoteArr.count == 3 {
            leftQuoteView.updateData(entity: quoteArr.first!)
            centerQuoteView.updateData(entity: quoteArr[1])
            rightQuoteView.updateData(entity: quoteArr.last!)
        }
        if let newsArr = entity.newsArray, newsArr.count > 0 {
            newsFlashView.updateData(entity: newsArr.first!)
        }
    }
    
}
