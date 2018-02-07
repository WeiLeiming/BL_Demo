//: Playground - noun: a place where people can play

import UIKit

var str = "1122221555521681654168"

//let range = str.range(of: "He")
// Range
//print(range)

class NumClass {
    var num = 1
    
}
let numClass = NumClass()
var num1 = [numClass,2,3,4] as [Any]
var num2 = [numClass,2,3,4] as [Any]

if num1 == num2 {
    print("num1、num2相等")
} else{
    print("num1、num2不等")
}


let attrstring = NSMutableAttributedString(string: str)
var ocStr = NSString(string: str)

let range = ocStr.range(of: "22")
range.location
NSMaxRange(range)
print(range)
ocStr = ocStr.substring(from: range.location) as NSString
attrstring.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)

let tmp = ocStr.substring(with: range)

//let arr = rangeOfSubString("22222", inString: str)
//str.rangeOfSubString("1")

//func rangeOfSubString(_ subStr: String, inString str: String) -> Array<NSRange> {
//    guard subStr.count > 0, str.contains(subStr) else {
//        return []
//    }
//    var rangeArray = [NSRange]()
//    var index: Int = 0
//    var ocStr = NSString(string: str)
//    while ocStr.contains(subStr) {
//        let range = ocStr.range(of: subStr)
//        rangeArray.append(NSMakeRange(index + range.location, subStr.count))
//        index += NSMaxRange(range)
//        ocStr = ocStr.substring(from: NSMaxRange(range)) as NSString
//    }
//    return rangeArray
//}

extension String {
    func rangeOfSubString(_ subStr: String) -> Array<NSRange> {
        guard subStr.count > 0, self.contains(subStr) else {
            return []
        }
        var rangeArray = [NSRange]()
        var index: Int = 0
        var ocStr = NSString(string: self)
        while ocStr.contains(subStr) {
            let range = ocStr.range(of: subStr)
            rangeArray.append(NSMakeRange(index + range.location, subStr.count))
            index += NSMaxRange(range)
            ocStr = ocStr.substring(from: NSMaxRange(range)) as NSString
        }
        return rangeArray
    }
}
