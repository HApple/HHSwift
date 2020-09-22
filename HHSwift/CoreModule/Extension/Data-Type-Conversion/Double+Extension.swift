//
//  Double+Extension.swift
//  HHSwift
//
//  Created by hjn on 2020/1/10.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import Darwin

extension Double {
    
    /**
     向下取第几位小数
     
     - parameter places: 第几位小数 ，1
     
     15.96 * 10.0 = 159.6
     floor(159.6) = 159.0
     159.0 / 10.0 = 15.9
     
     - returns:  15.96 =  15.9
     */
    func f(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.floor(self * divisor) / divisor
    }
    
    /**
     向下取第几位小数
     
     - parameter places: 第几位小数 ，1
     
     15.96 * 10.0 = 159.6
     floor(159.6) = 159.0
     159.0 / 10.0 = 15.9
     
     - returns:  15.96 =  15.9
     */
    func toFloor(_ places:Int) -> String {
        let divisor = pow(10.0, Double(places))
    
        
        return (Darwin.floor(self * divisor) / divisor).toString(maxF: places)
        
        
    }
    
    /**
     转化为字符串格式
     
     - parameter minF: 设置小数点后最少几位（不足补0）
     - parameter maxF: 设置小数点后最多几位
     - parameter minI: 设置最小整数位数（不足的前面补0）
     - returns:
     */
    func toString(_ minF: Int = 0, maxF: Int = 8, minI: Int = 1) -> String {
        let valueDecimalNumber = NSDecimalNumber(value: self as Double)
        let twoDecimalPlacesFormatter = NumberFormatter()
        twoDecimalPlacesFormatter.maximumFractionDigits = maxF
        twoDecimalPlacesFormatter.minimumFractionDigits = minF
        twoDecimalPlacesFormatter.minimumIntegerDigits = minI
        return twoDecimalPlacesFormatter.string(from: valueDecimalNumber)!
    }
    
    /**
     转化为百分数字符串
     - parameter maxF:
     
     - returns:
     */
    func toPercent(maxF: Int = 2) -> String {
        let percent = (self * 100).toString(maxF: maxF)
        return percent + "%"
    }
        
}


/**
 NumberFormatter
 
 原始值 = 1234.5678
 none = 1235           //四舍五入的整数
 decimal = 1,234.568   //小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入
 percent = 123,457%    //百分数形式
 scientific = 1.2345678E3  //科学计数
 spellOut = one thousand two hundred thirty-four point five six seven eight //朗读形式（英文表示
 ordinal = 1,235th //序数形式
 currency = $1,234.57 //货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）
 currencyISOCode = USD 1,234.57 //货币形式
 currencyPlural = 1,234.57 US dollars //货币形式
 currencyAccounting = $1,234.57  //会计计数
 
 */
