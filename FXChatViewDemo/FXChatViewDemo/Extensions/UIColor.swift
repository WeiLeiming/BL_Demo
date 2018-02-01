//
//  FxColor.swift
//  FxCommon
//
//  Created by Fang on 2017/7/3.
//  Copyright © 2017年 Byron. All rights reserved.
//

import UIKit

extension UIColor {
  
    static func rgbToColor(r: Int, g: Int, b: Int, a: CGFloat = 1.0) -> UIColor {
    return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
  }

  static func colorWithHexString(hex:String, alpha: CGFloat = 1) ->UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

  static let fxNavbar = UIColor.colorWithHexString(hex:"#2ea9df")          //< 导航栏颜色
  static let fxClear = UIColor.clear                    //< clear
  static let fxWhite = UIColor.white                    //< 白色
  static let fxBlack = UIColor.colorWithHexString(hex:"#545a64")            //< 正常黑色
  static let fxDeepBlack = UIColor.colorWithHexString(hex:"#212121")        //< 深黑色
  static let fxGray = UIColor.colorWithHexString(hex:"#909090")             //< 灰色
  static let fxLittleGray = UIColor.colorWithHexString(hex:"#acb2c1")      //<  浅灰色
  static let fxGrayPurple = UIColor.colorWithHexString(hex: "#a8b3d3")      //< 灰紫色
  static let fxBlue = UIColor.colorWithHexString(hex: "#2ea9df")            //< 蓝色
  static let fxDeepBlue = UIColor.colorWithHexString(hex: "#1485B7")        //< 深蓝色
  static let fxDDppBlue = UIColor.colorWithHexString(hex: "#0b6ed3")        //< 深深深的蓝色
  static let fxPaleBlue = UIColor.colorWithHexString(hex: "#96d4ef")        //< 淡淡的蓝色
  static let fxDeepPaleBlue = UIColor.colorWithHexString(hex: "#259dd1")    //< 淡淡的蓝色在深一点
  static let fxDarkGreyBlue = UIColor.colorWithHexString(hex: "#253448")
  static let fxDodgerBlue = UIColor.colorWithHexString(hex: "#41a2ff")
  static let fxRed = UIColor.colorWithHexString(hex: "#e36251")             //< 红色
  static let fxNavRed = UIColor.colorWithHexString(hex: "#fe3131")          //< 赠金导航栏红色
  static let fxRedSystem = UIColor.red                  //< 系统红色
  static let fxRedNotice = UIColor.colorWithHexString(hex: "#ff3b36")       //< 通知红色
  static let fxOrange = UIColor.colorWithHexString(hex: "#eb887b")          //< 粉红色
  static let fxGreen = UIColor.colorWithHexString(hex: "#72d465")           //< 绿色
  static let fxGreenSub = UIColor.colorWithHexString(hex: "#43B591")        //< 反正带点绿
  static let fxDeepGreen = UIColor.colorWithHexString(hex: "#44a989")       //< 深绿色
  static let fxYellow = UIColor.colorWithHexString(hex: "#f6B322")          //< 黄色
  static let fxPaleYellow = UIColor.colorWithHexString(hex: "#fbe1a7")      //< 淡淡的黄色
  static let fxOrangYellow = UIColor.colorWithHexString(hex: "#f68322")     //< 橙黄色
  static let fxBackGround = UIColor.colorWithHexString(hex: "#f7f7f8")      //< 背景色(table)
  static let fxChatBackGround = UIColor.colorWithHexString(hex: "#ebebeb")  //< 聊天页面的背景色 16-08-20
  static let fxGrayWhiteBottom = UIColor.colorWithHexString(hex: "#f7f7f7") //< 底部菜单灰白色
  static let fxGrayWhite = UIColor.colorWithHexString(hex: "#f6f6f7")       //< 灰白 cell按下去颜色
  static let fxPaleGray = UIColor.colorWithHexString(hex: "#cccccc")        //< 浅灰色
  static let fxGrayGreen = UIColor.colorWithHexString(hex: "#ff0000")       //< 灰绿
  static let fxGrayYellow = UIColor.colorWithHexString(hex: "#fffaef")      //< 灰黄
  static let fxCoolGrey = UIColor.colorWithHexString(hex: "#8c909b")
  static let fxLine = UIColor.colorWithHexString(hex: "#dddddd")            //< 分割线
  static let fxBtnHighlighted = UIColor.colorWithHexString(hex: "#13749E")  //< button 按下去颜色
  static let fxOverhead = UIColor.colorWithHexString(hex: "#FFFDF4")        //< 聊天列表顶置颜色
  static let fxForeMallDetailBottom = UIColor.colorWithHexString(hex: "#7ac1ec")    //< 聊天列表顶置颜色
  static let fxBonusYellow = UIColor.colorWithHexString(hex: "#f4cb6d")      //<赠金 发送的黄色 YES
  static let fxBonusYellowAlpha = UIColor.colorWithHexString(hex: "#99f4cb") //<赠金 发送的黄色 NO
  static let fxBonusRed = UIColor.colorWithHexString(hex: "#ea5e2c")         //<赠金 发送的红色
    
    static func rgbColor(_ r: Int, _ g: Int, _ b: Int) -> UIColor{
        return UIColor(red: CGFloat(r)/255.0,
                       green: CGFloat(g)/255.0,
                       blue: CGFloat(b)/255.0, alpha: 1)
    }
    
    static func fxTextGray() -> UIColor{
        return UIColor.rgbColor(144, 144, 144)
    }
    
    static func fxTextBlack() -> UIColor{
        return UIColor.rgbColor(48, 48, 48)
    }
    
    static func fxLightBlue() -> UIColor{
        return UIColor.rgbColor(46, 169, 223)
    }
    
    static func fxPriceRed() -> UIColor{
        return UIColor.rgbColor(243, 86, 86)
    }
    
    static func fxPriceGreen() -> UIColor{
        return UIColor.rgbColor(0, 176, 124)
    }
    
    static func fxWhiteGray() -> UIColor{
        return UIColor.rgbColor(246 , 247, 249)
    }
    
    static func fxGraySeperator() -> UIColor{
        return UIColor.rgbColor(221 , 221, 221)
    }
    
    static func fxTableViewHeader() -> UIColor{
        return UIColor.rgbColor(247 , 247, 247)
    }
}
