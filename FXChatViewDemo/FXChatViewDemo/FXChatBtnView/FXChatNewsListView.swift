//
//  FXChatNewsListView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/15.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit

/// 新闻列表背景颜色
private let newsListBgColor = UIColor.rgbToColor(r: 250, g: 248, b: 244)

// MARK: - 输出代理
protocol FXChatNewsListViewDelegate: class {
    func onClickNewsListCell(entity: FXChatNewsFlashEntity)
}

// MARK: - 新闻列表页
class FXChatNewsListView: UIView {

    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = newsListBgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    let tableView = UITableView()
    var dataSource = [FXChatNewsFlashEntity]()
    
    weak var delegate: FXChatNewsListViewDelegate?
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatNewsListView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // tableView
        let rect = CGRect(x: 0, y: 0, width: self.fx_width, height: 0)
        tableView.frame = rect
        tableView.backgroundColor = newsListBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(FXChatNewsListCell.self, forCellReuseIdentifier: FXChatNewsListCell.getIdentifier())

        // Add SubView
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        // tableView
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FXChatNewsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FXChatNewsListCell.getIdentifier(), for: indexPath) as! FXChatNewsListCell
        let entity = dataSource[indexPath.row]
        cell.updateData(entity: entity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = dataSource[indexPath.row]
        self.delegate?.onClickNewsListCell(entity: entity)
    }
    
}

// MARK: - Update Data
extension FXChatNewsListView {
    
    /// 更新数据
    func updateData(entity: FXChatFlashEntity) {
        if let newsArr = entity.newsArray, newsArr.count > 0 {
            dataSource = newsArr
        }
    }
    
}

