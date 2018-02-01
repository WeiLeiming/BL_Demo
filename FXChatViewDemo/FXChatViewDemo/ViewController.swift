//
//  ViewController.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/13.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.rgbToColor(r: 240, g: 240, b: 243)
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 64))
        navView.backgroundColor = UIColor.rgbToColor(r: 46, g: 169, b: 223)
        self.view.addSubview(navView)
        
        // 构建假数据
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
        
        let topView = FXChatTopView()
//        topView.delegate = self
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
        }
        
        let btnViewRect = CGRect(x: 375-39-8, y: 75, width: 39, height: 92.5)
        let btnView = FXChatBtnView(frame: btnViewRect)
        btnView.delegate = self
        self.view.addSubview(btnView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: FXChatTopViewOutput {
    
//    func onClickQuoteView(entity: FXChatQuoteFlashEntity) {
//        print(entity)
//    }
//
//    func onClickMoreQuoteBtn() {
//
//    }
//
//    func onClickNewsFlashView(entity: FXChatNewsFlashEntity) {
//        print(entity)
//    }
    
}

extension ViewController: FXChatBtnViewOutput {
    
    func onClickQuoteView(entity: FXChatQuoteFlashEntity) {
        print(entity)
    }

    func onClickMoreQuoteBtn() {

    }

    func onClickNewsFlashView(entity: FXChatNewsFlashEntity) {
        print(entity)
    }

}
