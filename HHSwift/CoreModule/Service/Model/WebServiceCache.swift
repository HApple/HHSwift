//
//  WebserviceCache.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import RealmSwift

class WebServiceCache: Object {

    @objc dynamic var url: String = ""
    @objc dynamic var params: String = ""
    @objc dynamic var result: String = ""
    
    
    @objc dynamic var key: String = ""
    
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    
    /// 用 url 和参数组成的唯一 key
    /// - Parameters:
    ///   - url: 请求的 url
    ///   - params: 请求的参数
    class func generateCacheKey(url: String, params:[String:Any]) -> String {
        let urlMd5 = url.md5()
        let params5 = params.description.md5()
        return (urlMd5 + params5).md5()
    }
    
}
