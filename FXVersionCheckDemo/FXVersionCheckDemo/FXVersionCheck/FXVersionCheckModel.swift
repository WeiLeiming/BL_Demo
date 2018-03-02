//
//  FXVersionCheckModel.swift
//  FXVersionCheckDemo
//
//  Created by bailun on 2018/3/1.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - Model representing a selection of results from http://testfxchatapi.fx110.com/swagger/ui/index.html#!/AppUpdateApi/AppUpdateApi_Get API
class FXVersionCheckModel: Mappable {
    
    var deviceGuid: String?
    var deviceType: String?
    var typeVersion: String?
    var typeVersionUrl: String?
    var description: String?
    var versionNumber: String?
    var isForced: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        deviceGuid <- map["DeviceGuid"]
        deviceType <- map["DeviceType"]
        typeVersion <- map["TypeVersion"]
        typeVersionUrl <- map["TypeVersionUrl"]
        description <- map["Description"]
        versionNumber <- map["VersionNumber"]
        isForced <- map["IsForced"]
    }
    
}

/*
 {\"DeviceGuid\":\"63ab5b48-2a05-4ee6-95d2-18d5368d6eed\",\"DeviceType\":1,\"TypeVersion\":\"1.0.0.0\",\"TypeVersionUrl\":\"http://10.0.0.147:1005/soft/RemitChat.ipa\",\"Description\":\"更改了什么\",\"VersionNumber\":0,\"IsForced\":false,\"TabllModels\":[]}
 */
