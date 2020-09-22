//
//  HHConstants.swift
//  HHSwift
//
//  Created by Jn.Huang on 2020/1/27.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import UIKit

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
// 判断是否为 iPhone X
let isIphoneX = kScreenH >= 812 ? true : false
// 状态栏高度
let kStatueHeight : CGFloat = isIphoneX ? 44 : 20
// 导航栏高度
let kNavigationBarHeight :CGFloat = 44
// TabBar高度
let kTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
// 宽度比
let kWidthRatio = kScreenW / 375.0
// 高度比
let kHeightRatio = kScreenH / 667.0

// 自适应
func Adapt(_ value : CGFloat) -> CGFloat {
    
    return AdaptW(value)
}

// 自适应宽度
func AdaptW(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kWidthRatio
}

// 自适应高度
func AdaptH(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kHeightRatio
}

// 常规字体
func FontSize(_ size : CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: AdaptW(size))
}

// 加粗字体
func BoldFontSize(_ size : CGFloat) -> UIFont {
    
    return UIFont.boldSystemFont(ofSize: AdaptW(size))
}
