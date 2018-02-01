//
//  FXChatBtnView.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/13.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit
import SnapKit

/// 动画时长
private let kAnimationDuration = 0.25
/// 简讯距离右边屏幕的距离
private let kFlashRightMargin: CGFloat = 55.0
/// 报价和新闻按钮的高度
private let kBtnHeight: CGFloat = 39.0
/// 报价简讯视图的高度
private let kQuoteViewHeight: CGFloat = 44.0
/// 新闻简讯视图的高度
private let kNewsViewHeight: CGFloat = 63.0
/// 新闻列表页高度
//private let kNewsListHeight: CGFloat = 360

/// 报价按钮图片
private let quoteBtnNormalImage = UIImage(named: "homeQuoteIcon")//R.image.chat_quoteBtn_normal()
private let quoteBtnSelectedImage = UIImage(named: "homeQuoteIconPressed")//R.image.chat_quoteBtn_selected()
/// 新闻按钮图片
private let newsBtnNormalImage = UIImage(named: "homeNewsIcon")//R.image.chat_newsBtn_normal()
private let newsBtnSelectedImage = UIImage(named: "homeNewsIconPressed")//R.image.chat_newsBtn_selected()

// MARK: - 输出代理
protocol FXChatBtnViewOutput: class {
    func onClickQuoteView(entity: FXChatQuoteFlashEntity)
    func onClickMoreQuoteBtn()
    func onClickNewsFlashView(entity: FXChatNewsFlashEntity)
}

// MARK: - 输入
protocol FXChatBrnViewInput {
    func updateData(entity: FXChatFlashEntity)
}

typealias FXChatBtnViewDelegate = FXChatBtnViewOutput

// MARK: - 整体视图，装载其他子视图
class FXChatBtnView: UIView {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupUI()
        addKeybordNotification()
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
    
    // MARK: - dealloc
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Properties
    
    lazy var kNewsListHeight: CGFloat = {
        let height = 360.0 / 603.0 * (self.superview?.bounds.size.height)!
        return height
    }()
    
    /// 显示报价页面按钮
    let quoteButton = UIButton()
    /// 显示新闻页面按钮
    let newsButton = UIButton()
    /// 报价页面
    var quoteView: FXChatQuoteFlashView?
    /// 新闻页面
    var newsView: FXChatNewsFlashView?
    /// 新闻列表页面
    var newsListView: FXChatNewsListView?
    /// 是否弹出新闻列表页
    var isPopNewsList = false
    
    /// 数据源
    var flashEntity: FXChatFlashEntity?
    /// 代理
    weak var delegate: FXChatBtnViewDelegate?
    
}

// MARK: - Setup UI Style & Constraint
extension FXChatBtnView {
    
    /// 设置界面
    func setupUI() {
        setupUIStyle()
        setupConstraints()
    }
    
    private func setupUIStyle() {
        // quoteButton
        quoteButton.setImage(quoteBtnNormalImage, for: .normal)
        quoteButton.setImage(quoteBtnSelectedImage, for: .selected)
        quoteButton.addTarget(self, action: #selector(FXChatBtnView.quoteBtnClicked(_:)), for: .touchUpInside)
        // newsButton
        newsButton.setImage(newsBtnNormalImage, for: .normal)
        newsButton.setImage(newsBtnSelectedImage, for: .selected)
        newsButton.addTarget(self, action: #selector(FXChatBtnView.newsBtnClicked(_:)), for: .touchUpInside)
        
        self.addSubview(quoteButton)
        self.addSubview(newsButton)
    }
    
    private func setupConstraints() {
        // quoteButton
        quoteButton.snp.makeConstraints { (make) in
            make.height.equalTo(kBtnHeight)
            make.width.equalTo(kBtnHeight)
            make.top.right.equalTo(self)
        }
        // newsButton
        newsButton.snp.makeConstraints { (make) in
            make.height.equalTo(kBtnHeight)
            make.width.equalTo(kBtnHeight)
            make.top.equalTo(quoteButton.snp.bottom).offset(15)
            make.right.equalTo(self)
        }
    }
    
}

// MARK: - Notification
extension FXChatBtnView {
    
    func addKeybordNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(FXChatBtnView.keyboardWasShown(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWasShown(_ notification: Notification) {
        if isPopNewsList {
            self.hideNewsListView()
        }
    }
    
}

// MARK: - Event
extension FXChatBtnView {
    
    func quoteBtnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            showQuoteView()
        } else {
            hideQuoteView()
        }
    }
    
    func newsBtnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            showNewsView()
        } else {
            if isPopNewsList {
                hideNewsListView(completion: { (completed) in
                    self.hideNewsView()
                })
            } else {
                hideNewsView()
            }
        }
    }
    
}

// MARK: - Show & Hide View
extension FXChatBtnView {
    
    /// 自动检测显示/隐藏新闻列表页
    func autoShowOrHideNewsListView() {
        if isPopNewsList {
            hideNewsListView()
        } else {
            showNewsListView()
        }
    }
    
    /// 显示报价视图
    func showQuoteView() {
        guard quoteView == nil else {
            return
        }
        let rect = CGRect(x: kFlashRightMargin - UIScreen.main.bounds.size.width,
                          y: self.fx_top - (kQuoteViewHeight - kBtnHeight) / 2,
                          width: UIScreen.main.bounds.size.width - kFlashRightMargin,
                          height: kQuoteViewHeight)
        quoteView = FXChatQuoteFlashView(frame: rect)
        quoteView!.setupUI()
        quoteView!.delegate = self
        if let entity = flashEntity {
            quoteView!.updateData(entity: entity)
        }
        self.superview?.addSubview(quoteView!)

        UIView.animate(withDuration: kAnimationDuration) {
            let rect = CGRect(x: 0,
                              y: self.quoteView!.fx_top,
                              width: self.quoteView!.fx_width,
                              height: self.quoteView!.fx_height)
            self.quoteView!.frame = rect
        }
    }
    
    /// 隐藏报价视图
    func hideQuoteView() {
        guard let uQuoteView = quoteView else {
            return
        }
        UIView.animate(withDuration: kAnimationDuration, animations: {
            let rect = CGRect(x: kFlashRightMargin - UIScreen.main.bounds.size.width,
                              y: uQuoteView.fx_top,
                              width: uQuoteView.fx_width,
                              height: uQuoteView.fx_height)
            uQuoteView.frame = rect
        }, completion: { (completed) in
            uQuoteView.removeFromSuperview()
            self.quoteView = nil
        })
    }
    
    /// 显示新闻视图
    func showNewsView() {
        guard newsView == nil else {
            return
        }
        let rect = CGRect(x: kFlashRightMargin - UIScreen.main.bounds.size.width,
                          y: self.fx_top + kQuoteViewHeight - (kQuoteViewHeight - kBtnHeight) / 2,
                          width: UIScreen.main.bounds.size.width - kFlashRightMargin,
                          height: kNewsViewHeight)
        newsView = FXChatNewsFlashView(frame: rect)
        newsView!.setupUI()
        newsView!.delegate = self
        
        if let entity = flashEntity {
            newsView!.updateData(entity: entity)
        }
        self.superview?.addSubview(newsView!)
        
        UIView.animate(withDuration: kAnimationDuration) {
            let rect = CGRect(x: 0,
                              y: self.newsView!.fx_top,
                              width: self.newsView!.fx_width,
                              height: self.newsView!.fx_height)
            self.newsView!.frame = rect
        }
    }
    
    /// 隐藏新闻视图
    func hideNewsView() {
        guard let uNewsView = newsView else {
            return
        }
        UIView.animate(withDuration: kAnimationDuration, animations: {
            let rect = CGRect(x: kFlashRightMargin - UIScreen.main.bounds.size.width,
                              y: uNewsView.fx_top,
                              width: uNewsView.fx_width,
                              height: uNewsView.fx_height)
            uNewsView.frame = rect
        }, completion: { (completed) in
            uNewsView.removeFromSuperview()
            self.newsView = nil
        })
    }
    
    /// 显示新闻列表
    func showNewsListView(completion: ((Bool) -> Swift.Void)? = nil) {
        guard let uNewsView = newsView, newsListView == nil else {
            return
        }
        let rect = CGRect(x: 0,
                          y: uNewsView.fx_bottom,
                          width: UIScreen.main.bounds.size.width - kFlashRightMargin,
                          height: 0)
        newsListView = FXChatNewsListView(frame: rect)
        newsListView!.setupUI()
        newsListView!.delegate = self
        
        if let entity = flashEntity {
            newsListView!.updateData(entity: entity)
        }
        self.superview?.addSubview(newsListView!)
        
        uNewsView.popMoreNewsBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        UIView.animate(withDuration: kAnimationDuration, animations: {
            
            let rect = CGRect(x: self.newsListView!.fx_left,
                              y: self.newsListView!.fx_top,
                              width: self.newsListView!.fx_width,
                              height: self.kNewsListHeight)
            self.newsListView!.frame = rect
            
            let tableViewRect = CGRect(x: 0,
                                       y: 0,
                                       width: self.newsListView!.fx_width,
                                       height: self.kNewsListHeight - 17)
            self.newsListView!.tableView.frame = tableViewRect
            
            // 圆角
            let maskPath = UIBezierPath(roundedRect: self.newsListView!.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.newsListView!.bounds
            maskLayer.path = maskPath.cgPath
            self.newsListView!.layer.mask = maskLayer
        }, completion: { (completed) in
            self.isPopNewsList = true
            if completion != nil {
                completion!(completed)
            }
        })

        

    }
    
    /// 隐藏新闻列表
    func hideNewsListView(completion: ((Bool) -> Swift.Void)? = nil) {
        guard let uNewsView = newsView, let uNewsListView = newsListView else {
            return
        }
        uNewsView.popMoreNewsBtn.transform = CGAffineTransform(rotationAngle: 2 * CGFloat(Double.pi))
        UIView.animate(withDuration: kAnimationDuration, animations: {
            let rect = CGRect(x: uNewsListView.fx_left,
                              y: uNewsListView.fx_top,
                              width: uNewsListView.fx_width,
                              height: 0)
            uNewsListView.frame = rect
            
            let tableViewRect = CGRect(x: 0,
                                       y: 0,
                                       width: uNewsListView.fx_width,
                                       height: 0)
            uNewsListView.tableView.frame = tableViewRect
        }, completion: { (completed) in
            uNewsListView.removeFromSuperview()
            self.newsListView = nil
            self.isPopNewsList = false
            if completion != nil {
                completion!(completed)
            }
        })
    }
    
}

// MARK: - FXChatQuoteFlashViewDelegate
extension FXChatBtnView: FXChatQuoteFlashViewDelegate {
    
    func moreQuoteBtnClicked() {
        self.delegate?.onClickMoreQuoteBtn()
    }
    
    func leftQuoteViewTap(entity: FXChatQuoteFlashEntity) {
        self.delegate?.onClickQuoteView(entity: entity)
    }
    
    func centerQuoteViewTap(entity: FXChatQuoteFlashEntity) {
        self.delegate?.onClickQuoteView(entity: entity)
    }
    
    func rightQuoteViewTap(entity: FXChatQuoteFlashEntity) {
        self.delegate?.onClickQuoteView(entity: entity)
    }
    
}

// MARK: - FXChatNewsFlashViewDelegate
extension FXChatBtnView: FXChatNewsFlashViewDelegate {
    
    func newsFlashViewTap(entity: FXChatNewsFlashEntity) {
        self.delegate?.onClickNewsFlashView(entity: entity)
    }
    
    func popNewsListViewBtnClicked() {
        autoShowOrHideNewsListView()
    }
    
}

// MARK: - FXChatNewsListViewDelegate
extension FXChatBtnView: FXChatNewsListViewDelegate {
    
    func onClickNewsListCell(entity: FXChatNewsFlashEntity) {
        self.delegate?.onClickNewsFlashView(entity: entity)
    }
    
}

// MARK: - FXChatBrnViewInput
extension FXChatBtnView: FXChatBrnViewInput {
    
    func updateData(entity: FXChatFlashEntity) {
        flashEntity = entity
        quoteView?.updateData(entity: entity)
        newsView?.updateData(entity: entity)
        newsListView?.updateData(entity: entity)
    }
    
}
