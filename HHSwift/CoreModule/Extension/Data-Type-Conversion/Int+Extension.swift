//
//  Int+Extension.swift
//  HHSwift
//
//  Created by hjn on 2020/1/10.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

extension Int {
    
    /**
     转化为字符串格式
     - returns:
     */
    func toString() -> String {
        return String(self)
    }
    
    /**
     把布尔变量转化为Int
     - returns:
     */
    init(_ value: Bool) {
        if value {
            self.init(1)
        } else {
            self.init(0)
        }
    }
    
    
    /// 转为bool型
    ///
    /// - Returns:
    func toBool() -> Bool {
        if self > 0 {
            return true
        } else {
            return false
        }
    }
}


extension Int64 {
    
    /**
     转化为字符串格式
     - returns:
     */
    func toString() -> String {
        return String(self)
    }
    
    /**
     把布尔变量转化为Int
     - returns:
     */
    init(_ value: Bool) {
        if value {
            self.init(1)
        } else {
            self.init(0)
        }
    }
    
    /// 转为bool型
    ///
    /// - Returns:
    func toBool() -> Bool {
        if self > 0 {
            return true
        } else {
            return false
        }
    }
}


//MARK: - 在指定范围内生成随机数，同时每次生成的随机数都不重复
extension Int {
    
    //随机数生成函数
    func createRandomMan(start: Int, end: Int) ->() ->Int? {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end {
            nums.append(i)
        }
        
        func randomMan() -> Int? {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                return nil
            }
        }
        
        return randomMan
        
    }
}
