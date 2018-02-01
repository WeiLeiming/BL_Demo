//
//  FXWelcomeGroupCell.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/17.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// Cell背景颜色
private let kGroupCellBgColor = UIColor.rgbToColor(r: 247, g: 247, b: 247)
/// 群名字体颜色
private let kGroupNameTextColor = UIColor.rgbToColor(r: 84, g: 90, b: 100)
/// 加群按钮背景颜色 -- Normal
private let kAddGroupBtnNormalBgColor = UIColor.rgbToColor(r: 255, g: 255, b: 255)
/// 加群按钮字体颜色 -- Normal
private let kAddGroupBtnNormalTextColor = UIColor.rgbToColor(r: 84, g: 90, b: 100)
/// 加群按钮背景颜色 -- Selected
private let kAddGroupBtnSelectedBgColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
/// 加群按钮字体颜色 -- Selected
private let kAddGroupBtnSelectedTextColor = UIColor.rgbToColor(r: 255, g: 255, b: 255)
/// 加群按钮边框颜色
private let kAddGroupBtnBorderColor = UIColor.rgbToColor(r: 221, g: 221, b: 221)

class FXWelcomeGroupCell: UITableViewCell {
    
    // MARK: - Initializations
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kGroupCellBgColor
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 群头像
    let groupHeadImageView = UIImageView()
    /// 群名
    let groupNameLabel = UILabel()
    /// 加群按钮
    let addGroupBtn = UIButton()
    /// 点击加群回调
    var addGroupClosure: (() -> Void)?
    
    // MARK: - Reuse Identifier
    
    /// 获取重用标识符
    class func getIdentifier() -> String {
        return NSStringFromClass(FXWelcomeGroupCell.self)
    }

}

// MARK: - Setup UI Style & Constraint
extension FXWelcomeGroupCell {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // groupHeadImageView
        groupHeadImageView.layer.cornerRadius = 15
        groupHeadImageView.layer.masksToBounds = true
        // groupNameLabel
        groupNameLabel.font = groupNameLabel.font.withSize(14)
        groupNameLabel.textColor = kGroupNameTextColor
        groupNameLabel.textAlignment = .center
        // addGroupBtn
        setupNormalBtnStyle()
        addGroupBtn.titleLabel?.font = addGroupBtn.titleLabel?.font.withSize(13)
        addGroupBtn.layer.cornerRadius = 10
        addGroupBtn.layer.masksToBounds = true
        addGroupBtn.layer.borderWidth = 0.5
        addGroupBtn.layer.borderColor = kAddGroupBtnBorderColor.cgColor
        addGroupBtn.addTarget(self, action: #selector(FXWelcomeGroupCell.addGroupBtnClicked(_:)), for: .touchUpInside)
        
        // Add SubView
        self.addSubview(groupHeadImageView)
        self.addSubview(groupNameLabel)
        self.addSubview(addGroupBtn)
    }
    
    private func setupConstraints() {
        // groupHeadImageView
        groupHeadImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(13.5)
            make.bottom.equalTo(self)
            make.width.height.equalTo(30)
        }
        // groupNameLabel
        groupNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupHeadImageView)
            make.left.equalTo(groupHeadImageView.snp.right).offset(10)
            make.right.lessThanOrEqualTo(self).offset(-80)
        }
        // addGroupBtn
        addGroupBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupHeadImageView)
            make.right.equalTo(self).offset(-16.5)
            make.width.equalTo(52)
            make.height.equalTo(20)
        }
    }

    /// 设置按钮的默认状态
    func setupNormalBtnStyle() {
        addGroupBtn.isEnabled = true
        addGroupBtn.backgroundColor = kAddGroupBtnNormalBgColor
        addGroupBtn.setTitle("+加群", for: .normal)
        addGroupBtn.setTitleColor(kAddGroupBtnNormalTextColor, for: .normal)
    }
    
    /// 设置按钮的被选中状态
    func setupSelectedBtnStyle() {
        addGroupBtn.isEnabled = false
        addGroupBtn.backgroundColor = kAddGroupBtnSelectedBgColor
        addGroupBtn.setTitle("已申请", for: .normal)
        addGroupBtn.setTitleColor(kAddGroupBtnSelectedTextColor, for: .normal)
    }
    
}

// MARK: - Event
extension FXWelcomeGroupCell {
    func addGroupBtnClicked(_ sender: UIButton) {
        setupSelectedBtnStyle()
        self.addGroupClosure?()
    }
    
}

// MARK: - Update Data
extension FXWelcomeGroupCell {
    
    /// 更新数据
    func updateData(groupHeadImage: String, groupName: String, isAdd: Bool = false) {
        groupHeadImageView.image = UIImage(named: groupHeadImage)
        groupNameLabel.text = groupName
        if isAdd {
            setupSelectedBtnStyle()
        } else {
            setupNormalBtnStyle()
        }
    }
    
}
