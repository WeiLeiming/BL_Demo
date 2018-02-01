//
//  FXChatNewsFlashView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/13.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// 新闻时间颜色
private let newsTimeColor = UIColor.rgbToColor(r: 45, g: 169, b: 223)
/// 新闻来源颜色
private let newsSourceColor = UIColor.rgbToColor(r: 45, g: 169, b: 223)
/// 新闻内容颜色
private let newsContentColor = UIColor.rgbToColor(r: 37, g: 52, b: 72)

/// 更多新闻按钮图片
private let popMoreNewsBtnNormalImage = UIImage(named: "popupIcon")//R.image.chat_popNewsList()

// MARK: - 输出代理
protocol FXChatNewsFlashViewDelegate: class {
    func popNewsListViewBtnClicked()
    func newsFlashViewTap(entity: FXChatNewsFlashEntity)
}

// MARK: - 新闻视图，包含时间，来源，内容
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
        newsTimeLabel.font = newsTimeLabel.font.withSize(14)
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
            make.height.equalTo(20)
            make.top.equalTo(self)
            make.left.equalTo(self).offset(15)
        }
        // newsSourceLabel
        newsSourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(newsTimeLabel)
            make.left.equalTo(newsTimeLabel.snp.right).offset(7.5)
            make.right.lessThanOrEqualTo(self)
        }
        // newsContentLabel
        newsContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(18)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
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

// MARK: - 新闻简讯
class FXChatNewsFlashView: UIView {

    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fxWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 新闻简讯
    fileprivate let newsFlashView = NewsFlashView()
    /// 更多新闻内容按钮
    let popMoreNewsBtn = UIButton()
    
    /// 数据源
    var flashEntity: FXChatFlashEntity?
    /// Delegate
    weak var delegate: FXChatNewsFlashViewDelegate?
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatNewsFlashView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // newsFlashView
        newsFlashView.setupUI()
        let newsFlashGesture = UITapGestureRecognizer.init(target: self, action: #selector(FXChatTopView.newsFlashViewTap(_:)))
        newsFlashView.addGestureRecognizer(newsFlashGesture)
        // popMoreNewsBtn
        popMoreNewsBtn.setImage(popMoreNewsBtnNormalImage, for: .normal)
        popMoreNewsBtn.addTarget(self, action: #selector(FXChatNewsFlashView.popMoreNewsBtnClicked(_:)), for: .touchUpInside)
        
        // Add SubView
        self.addSubview(newsFlashView)
        self.addSubview(popMoreNewsBtn)
    }
    
    private func setupConstraints() {
        // newsFlashView
        newsFlashView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.bottom.left.equalTo(self)
            make.right.equalTo(self).offset(-41)
        }
        // popMoreNewsBtn
        popMoreNewsBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.right.bottom.equalTo(0)
        }
    }
    
}

// MARK: - Event
extension FXChatNewsFlashView {
    
    func newsFlashViewTap(_ sender: UITapGestureRecognizer) {
        guard let entity = flashEntity else {
            return
        }
        if let newsArr = entity.newsArray, newsArr.count > 0 {
            self.delegate?.newsFlashViewTap(entity: newsArr.first!)
        }
    }
    
    func popMoreNewsBtnClicked(_ sender: UIButton) {
        self.delegate?.popNewsListViewBtnClicked()
    }
    
}

// MARK: - Update Data
extension FXChatNewsFlashView {
    
    /// 更新数据
    func updateData(entity: FXChatFlashEntity) {
        flashEntity = entity
        if let newsArr = entity.newsArray, newsArr.count > 0 {
            newsFlashView.updateData(entity: newsArr.first!)
        }
    }
    
}
