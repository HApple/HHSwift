//
//  APIServerEnviromentType.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

public enum APIServerEnviromentType: Int {
    case dev = 0;
    case pro = 1;
    
    //域名
    var domain: String {
        switch self {
        case .dev:
            return "dev"
        case .pro:
            return "pro"
        }
    }
    
    var version: String {
        switch self {
        case .dev:
            return "1_0_0"
        case .pro:
            return "1_0_0"
        }
    }
    
    var apiUrl: String {
        switch self {
        case .dev:
            return "http://www." + self.domain
        case .pro:
             return "https://www." + self.domain
        }
    }
    
    /// Example -- 用户信息
    var apiUserUrl:String{
        switch self {
        case .dev:
            return "http://user.\(self.domain)/api/app/\(self.version)/"
        case .pro:
            return "https://user.\(self.domain)/api/app/\(self.version)/"
        }
    }
    
    /// 文件公开上传
    var apiPublicFileUrl:String{
        switch self {
        case .dev:
            return "http://file.\(self.domain)/api/app/image/public/"
        case .pro:
            return "https://file.\(self.domain)/api/app/image/public/"
        }
    }
    /// 与"文件公开上传"配对
    var apiGetPublicFileUrl:String{
        switch self {
        case .dev:
            return "http://file.\(self.domain)/image/public/"
        case .pro:
            return "https://file.\(self.domain)/image/public/"
        }
    }
    
}
