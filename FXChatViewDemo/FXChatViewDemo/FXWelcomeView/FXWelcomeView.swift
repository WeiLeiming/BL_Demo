//
//  FXWelcomeView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/17.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit
import SnapKit

/// 欢迎视图背景颜色
private let kWelcomeViewBgColor = UIColor.rgbToColor(r: 0, g: 0, b: 0, a: 0.75)
/// 头部群文本颜色
private let kHeadGroupTextColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
/// 群列表背景颜色
private let kGroupTableViewBgColor = UIColor.rgbToColor(r: 247, g: 247, b: 247)
/// 底部视图背景颜色
private let kBottomViewBgColor = UIColor.rgbToColor(r: 247, g: 247, b: 247)
/// 完成按钮背景颜色
private let kCompleteBtnBgColor = UIColor.rgbToColor(r: 246, g: 179, b: 34)
/// 换一批按钮字体颜色
private let kAnotherBtnTextColor = UIColor.rgbToColor(r: 183, g: 183, b: 183)

/// 头部欢迎图片
private let kHeadWelcomeImage = UIImage(named: "hello")
/// 头部群图片
private let kHeadGroupImage = UIImage(named: "invalidName")

// MARK: - FXWelcomeView
class FXWelcomeView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kWelcomeViewBgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    fileprivate let recommendView = RecommendView()
    
    // MARK: - Setup UI
    
    /// 设置界面
    func setupUI() {
        recommendView.setupUI()
        recommendView.delegate = self
        self.addSubview(recommendView)
        recommendView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(448)
            make.width.equalTo(290)
        }
    }
    
    // MARK: - Show & Hide View
    
    /// 显示欢迎视图
    ///
    /// - Parameter superView: 父视图。默认nil，添加欢迎视图至window
    func show(inView superView: UIView? = nil) {
        setupUI()
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

// MARK: - RecommendViewDelegate
extension FXWelcomeView: RecommendViewDelegate {
    
    /// 点击现在开始，移除欢迎视图
    func completeWelcome() {
        dismiss()
    }
    
    /// 点击换一批按钮
    func changeForAnotherGroup() {
        print("\(type(of: self)) ---> changeForAnotherGroup")
    }
    
}

// MARK: - RecommendView Out
protocol RecommendViewDelegate: class {
    func completeWelcome()
    func changeForAnotherGroup()
}

// MARK: - RecommendView
fileprivate class RecommendView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    /// 头部背景视图
    let topBgView = UIView()
    /// 欢迎图片
    let welcomeImageView = UIImageView()
    /// 头部群图片
    let groupImageView = UIImageView()
    /// 头部群文本
    let groupLabel = UILabel()
    /// 群列表
    let groupTableView = UITableView()
    /// 底部背景视图
    let bottomBgView = UIView()
    /// 完成按钮
    let completeBtn = UIButton()
    /// 换一批按钮
    let anotherGroupBtn = UIButton()
    
    /// 数据源
    var dataSource = [[String: Any?]]()
    var isAddStatusArr = Array(repeating: false, count: 10)
    
    /// 代理
    weak var delegate: RecommendViewDelegate?
    
    // MARK: - Setup UI
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // topBgView
        topBgView.backgroundColor = UIColor.fxWhite
        topBgView.layer.cornerRadius = 5
        topBgView.layer.masksToBounds = true
        // bottomBgView
        bottomBgView.backgroundColor = kBottomViewBgColor
        // welcomeImageView
        welcomeImageView.image = kHeadWelcomeImage
        // groupImageView
        groupImageView.image = kHeadGroupImage
        // groupLabel
        groupLabel.font = groupLabel.font.withSize(13)
        groupLabel.textColor = kHeadGroupTextColor
        groupLabel.textAlignment = .center
        groupLabel.text = "汇信群"
        // groupTableView
        groupTableView.backgroundColor = kGroupTableViewBgColor
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.estimatedRowHeight = 40
        groupTableView.separatorStyle = .none
        groupTableView.register(FXWelcomeGroupCell.self, forCellReuseIdentifier: FXWelcomeGroupCell.getIdentifier())
        // completeBtn
        completeBtn.setTitle("现在开启", for: .normal)
        completeBtn.titleLabel?.font = completeBtn.titleLabel?.font.withSize(15)
        completeBtn.backgroundColor = kCompleteBtnBgColor
        completeBtn.layer.cornerRadius = 12.5
        completeBtn.addTarget(self, action: #selector(RecommendView.completeBtnClicked(_:)), for: .touchUpInside)
        // anotherGroupBtn
        anotherGroupBtn.setTitle("换一批", for: .normal)
        anotherGroupBtn.titleLabel?.font = anotherGroupBtn.titleLabel?.font.withSize(12)
        anotherGroupBtn.setTitleColor(kAnotherBtnTextColor, for: .normal)
        anotherGroupBtn.addTarget(self, action: #selector(RecommendView.anotherGroupBtnClicked(_:)), for: .touchUpInside)
        
        // Add SubView
        self.addSubview(topBgView)
        topBgView.addSubview(bottomBgView)
        self.addSubview(welcomeImageView)
        self.addSubview(groupImageView)
        self.addSubview(groupLabel)
        self.addSubview(groupTableView)
        self.addSubview(completeBtn)
        self.addSubview(anotherGroupBtn)
    }
    
    private func setupConstraints() {
        // topBgView
        topBgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(73)
            make.left.right.equalTo(self)
            make.height.equalTo(375)
        }
        // bottomBgView
        bottomBgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(topBgView)
            make.height.equalTo(41.5)
        }
        // welcomeImageView
        welcomeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(83)
            make.width.equalTo(143.5)
            make.height.equalTo(128.5)
        }
        // groupImageView
        groupImageView.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(6.5)
            make.centerX.equalTo(self)
            make.width.height.equalTo(40)
        }
        // groupLabel
        groupLabel.snp.makeConstraints { (make) in
            make.top.equalTo(groupImageView.snp.bottom).offset(5.5)
            make.centerX.equalTo(self)
            make.height.equalTo(18.5)
        }
        // groupTableView
        groupTableView.snp.makeConstraints { (make) in
            make.top.equalTo(groupLabel.snp.bottom).offset(8)
            make.left.right.equalTo(self)
            make.bottom.equalTo(bottomBgView.snp.top)
        }
        // completeBtn
        completeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(95)
            make.height.equalTo(25)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        // anotherGroupBtn
        anotherGroupBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(completeBtn)
            make.right.equalTo(self).offset(-15)
        }
    }
    
}

// MARK: - Event
extension RecommendView {
    
    /// 点击现在开启按钮
    func completeBtnClicked(_ sender: UIButton) {
        self.delegate?.completeWelcome()
    }
    
    /// 点击换一批按钮
    func anotherGroupBtnClicked(_ sender: UIButton) {
        self.delegate?.changeForAnotherGroup()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RecommendView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FXWelcomeGroupCell.getIdentifier(), for: indexPath) as! FXWelcomeGroupCell
        cell.updateData(groupHeadImage: "invalidName", groupName: "外汇110学习群", isAdd: isAddStatusArr[indexPath.row])
        cell.addGroupClosure = { [weak self] () -> Void in
            self?.isAddStatusArr[indexPath.row] = true
        }
        return cell
    }
    
}
