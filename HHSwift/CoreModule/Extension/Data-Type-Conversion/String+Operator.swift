//
//  String+Operator.swift
//  HHSwift
//
//  Created by hjn on 2020/1/10.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

extension String {
    
    /**
     NSDecimalNumberHandler对象
     @param roundingMode 舍入方式
     @param scale 小数点后舍入值的位数
     @param exact 精度错误处理
     @param overflow 溢出错误处理
     @param underflow 下溢错误处理
     @param divideByZero 除以0的错误处理
     */
    private static var defaultBehavior = NSDecimalNumberHandler.init(roundingMode: .plain,
                                                                     scale: 0,
                                                                     raiseOnExactness: false,
                                                                     raiseOnOverflow: false,
                                                                     raiseOnUnderflow: false,
                                                                     raiseOnDivideByZero: false)
    
    public var decimalWrapper: NSDecimalNumber {
        get {
            return NSDecimalNumber(string: self)
        }
    }
    
    
    /// 四舍五入
    /// - Parameter scale: 小数点后舍入值的位数
    public func roundToPlain(_ scale: Int) -> String {
        
        if var origin = Decimal(string: self) {
            var result = Decimal()
            NSDecimalRound(&result, &origin, scale, .plain)
            return NSDecimalNumber(decimal: result).stringValue
        }
        return ""
    }
    
    
    /// 也是四舍五入,这是和 plain 不一样,如果精确的那位是5,
    /// 它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
    /// plain结果为1.3,而bankers则是1.2
    /// - Parameter scale: 小数点后舍入值的位数
    public func roundToBankers(_ scale: Int) -> String {
        
        if var origin = Decimal(string: self) {
            var result = Decimal()
            NSDecimalRound(&result, &origin, scale, .bankers)
            return NSDecimalNumber(decimal: result).stringValue
        }
        return ""
    }
    
    
    /// 只舍不入
    /// - Parameter scale: 小数点后舍入值的位数
    public func roundToUp(_ scale: Int) -> String {
        
        if var origin = Decimal(string: self) {
            var result = Decimal()
            NSDecimalRound(&result, &origin, scale, .up)
            return NSDecimalNumber(decimal: result).stringValue
        }
        return ""
    }
    
    
    /// 只入不舍
    /// - Parameter scale: 小数点后舍入值的位数
    public func roundToDown(_ scale: Int) -> String {
        
        if var origin = Decimal(string: self) {
            var result = Decimal()
            NSDecimalRound(&result, &origin, scale, .down)
            return NSDecimalNumber(decimal: result).stringValue
        }
        return ""
    }
    
    
    public static func +(lhs: String, rhs: String) -> String {
        
        if lhs.decimalWrapper == .notANumber || rhs.decimalWrapper == .notANumber {
            return lhs.appending(rhs)
        }
        
        return lhs.decimalWrapper.adding(rhs.decimalWrapper, withBehavior: defaultBehavior).stringValue
    }

    public static func -(lhs: String, rhs: String) -> String {
        
        return lhs.decimalWrapper.subtracting(rhs.decimalWrapper, withBehavior: defaultBehavior).stringValue
    }
    
    public static func *(lhs: String, rhs: String) -> String {
        
        return lhs.decimalWrapper.multiplying(by: rhs.decimalWrapper, withBehavior: defaultBehavior).stringValue
    }
    
    public static func /(lhs: String, rhs: String) -> String {
        
        return lhs.decimalWrapper.dividing(by: rhs.decimalWrapper, withBehavior: defaultBehavior).stringValue
    }
    
    public static func <(lhs: String, rhs: String) -> Bool {
        return lhs.decimalWrapper.compare(rhs.decimalWrapper) == .orderedAscending
    }
    
    public static func <=(lhs: String, rhs: String) -> Bool {
        return lhs.decimalWrapper.compare(rhs.decimalWrapper) != .orderedDescending
    }
    
    public static func >(lhs: String, rhs: String) -> Bool {
        return lhs.decimalWrapper.compare(rhs.decimalWrapper) == .orderedDescending
    }
    
    public static func >=(lhs: String, rhs: String) -> Bool {
        return lhs.decimalWrapper.compare(rhs.decimalWrapper) != .orderedAscending
    }

}
