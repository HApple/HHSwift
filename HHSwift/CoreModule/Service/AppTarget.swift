//
//  AppTarget.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

/// 发布App的target版本 方便打包
/// bundleid 遵循后缀添加.beta .inhouse .store以便区分
enum AppTargetType: String {
    case beta = "beta"
    case inhouse = "inhouse"
    case store = "store"
}

struct AppTarget {
    static var type: AppTargetType {
        let bundleId = Bundle.main
            .infoDictionary!["CFBundleIdentifier"] as! String
        var target:AppTargetType = .beta
        if bundleId.contains(".beta") {
            target = .beta
        }else if bundleId.contains(".inhouse") {
            target = .inhouse
        }else if bundleId.contains(".store") {
            target = .store
        }
        return target
    }
}
