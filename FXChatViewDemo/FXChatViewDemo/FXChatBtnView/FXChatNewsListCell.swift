//
//  FXChatNewsListCell.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/15.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// 新闻列表背景颜色
private let newsListBgColor = UIColor.rgbToColor(r: 250, g: 248, b: 244)
/// 新闻时间背景颜色
private let newsTimeBgColor = UIColor.rgbToColor(r: 233, g: 234, b: 236)
/// 新闻时间颜色
private let newsTimeColor = UIColor.rgbToColor(r: 45, g: 169, b: 223)
/// 新闻内容颜色, 通用
private let newsContentNormalColor = UIColor.rgbToColor(r: 84, g: 90, b: 100)
/// 新闻内容颜色, 重要
private let newsContentImportantColor = UIColor.rgbToColor(r: 227, g: 98, b: 81)

class FXChatNewsListCell: UITableViewCell {
    
    // MARK: - Initializations
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = newsListBgColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 新闻时间背景
    let newsTimeBgView = UIView()
    /// 新闻时间
    let newsTimeLabel = UILabel()
    /// 新闻内容
    let newsContentLabel = UILabel()
    
    // MARK: - Reuse Identifier
    
    /// 获取重用标识符
    class func getIdentifier() -> String {
        return NSStringFromClass(FXChatNewsListCell.self)
    }
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatNewsListCell {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // newsTimeBgView
        newsTimeBgView.backgroundColor = newsTimeBgColor
        newsTimeBgView.layer.cornerRadius = 9
        newsTimeBgView.layer.masksToBounds = true
        // newsTimeLabel
        newsTimeLabel.font = newsTimeLabel.font.withSize(13)
        newsTimeLabel.textColor = newsTimeColor
        newsTimeLabel.textAlignment = .center
        // newsContentLabel
        newsContentLabel.font = newsContentLabel.font.withSize(14)
        newsContentLabel.textColor = newsContentNormalColor
        newsContentLabel.numberOfLines = 0
        
        // Add SubView
        self.addSubview(newsTimeBgView)
        newsTimeBgView.addSubview(newsTimeLabel)
        self.addSubview(newsContentLabel)
    }
    
    private func setupConstraints() {
        // newsTimeBgView
        newsTimeBgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(15)
        }
        // newsTimeLabel
        newsTimeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(11)
            make.top.equalTo(newsTimeBgView).offset(3.5)
            make.bottom.equalTo(newsTimeBgView).offset(-3.5)
            make.left.equalTo(newsTimeBgView).offset(8.5)
            make.right.equalTo(newsTimeBgView).offset(-8.5)
        }
        // newsContentLabel
        newsContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(newsTimeBgView.snp.bottom).offset(2.5)
            make.right.equalTo(self).offset(-25)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
}

// MARK: - Update Data
extension FXChatNewsListCell {
    
    /// 更新数据
    func updateData(entity: FXChatNewsFlashEntity) {
        newsTimeLabel.text = entity.time
        newsContentLabel.text = entity.content
    }
    
}
