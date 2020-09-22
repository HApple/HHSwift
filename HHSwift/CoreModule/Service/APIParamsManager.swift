//
//  APIParamsManager.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import CryptoSwift

/**
 这里做个示范
 按文档 接口参数要求.md
 封装参数
 */
struct APIParamsManager {
    
    static let secretKey = "13b8e42848cbd317520bb889086c8978f0ee3358"
    
    /**
     步骤1. 对所有待签名参数先转成全部小写再按照字段名的ASCII 码从小到大排序（字典序）后，使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串string：
     
     market=usdt_btc&multiple=10&number=100&price=6800&types=1&uid=23437
     步骤2. 对string用secretkey进行HMAC-SHA1签名（使用secretkey做密钥），得到字节数组：
     
     步骤3. 对字节数组（不是上面的16进制小写字符串，如果传入是16进制的小写字符串，务必先转成字节数组）进行base64编码等到signature：
     
     4ptxZomBV0q4vjFbJT3l7LOeDJo=
     步骤4. 把Authorization的键值对放在header传输： Authorization = signature
     */
    static func configAuthParams(params: [String: Any]) -> String {
        
        let lowercasedParams = configLowercasedParams(params: params)
        let signParams = configSortConnetParams(params: lowercasedParams)
        
        //HMAC-SHA1签名
        let hmac = try! HMAC(key: secretKey.bytes, variant: .sha1).authenticate(signParams.bytes)

        //对字节数组（不是上面的16进制小写字符串，如果传入是16进制的小写字符串，务必先转成字节数组）进行base64编码等到signature：
        let signature = hmac.toBase64() ?? ""
        return signature
    }
    
    //全部小写
    static func configLowercasedParams(params: [String: Any]) -> [String: Any] {
        var finalParams: [String: Any] = [:]
        for key in params.keys {
            let lowerKey = key.lowercased()
            if let value = params[key] as? String {
                finalParams[lowerKey] = value.lowercased()
            }
        }
        return finalParams
    }
    
    //按照字段名的ASCII 码从小到大排序（字典序）后
    //使用键值对的格式（即key1=value1&key2=value2…）拼接成字符串string
    static func configSortConnetParams(params: [String: Any]) -> String {
        let keys = params.keys.sorted(by: <)
        var signParams:String = ""
        for (index,key) in keys.enumerated() {
            if let value = params[key] as? String {
                signParams.append("\(key)=\(value)")
                if index != keys.count - 1 {
                    signParams.append("&")
                }
            }
        }
        return signParams
    }
}
