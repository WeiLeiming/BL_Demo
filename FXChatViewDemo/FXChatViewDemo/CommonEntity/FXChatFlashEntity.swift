//
//  FXChatFlashEntity.swift
//  FXChatViewDemo
//
//  Created by bailun on 2018/1/26.
//  Copyright © 2018年 bailun. All rights reserved.
//

public struct FXChatFlashEntity {
    
    var quoteArray: [FXChatQuoteFlashEntity]?       // 报价数组
    var newsArray: [FXChatNewsFlashEntity]?         // 新闻数组
    
}

struct FXChatQuoteFlashEntity {
    
    var quoteID: String?                            // 报价ID
    var name: String?                               // 名称
    var index: String?                              // 指数
    
}

struct FXChatNewsFlashEntity {
    
    var newsID: String?                             // 新闻ID
    var time: String?                               // 时间
    var source: String?                             // 来源
    var content: String?                            // 内容
    
}
