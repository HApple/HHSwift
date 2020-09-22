//
//  RemoteService.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import Localize_Swift

class RemoteService: NSObject {
    
    static let shared:RemoteService = RemoteService()
    
    //API环境
    var apiType:APIServerEnviromentType {
        if AppTarget.type == .beta {
            return .dev
        }else {
            return .pro
        }
    }

    override init() {
        super.init()
    }
    
    /// 调用http接口
    /// - Parameters:
    ///   - url: 接口地址
    ///   - parameters: 传入参数
    ///   - useCache: 是否缓存 true 为缓存并且优先读取缓存 默认 false
    ///   - useWeb: true 为请求服务器数据  默认 true
    ///   - method: HTTPMethod  默认 post
    ///   - response: 回调处理
    internal func sendJsonRequest(_ url: String,
                                     parameters: [String: Any],
                                     useCache: Bool = false,
                                     useWeb: Bool = true,
                                     method:HTTPMethod = .post,
                                     response:@escaping (_ json: JSON, _ isCache: Bool) -> Void) {
        log.debug("接口地址: \(url)")
        log.debug("传入参数: \(parameters)")
        /**
         如果使用缓存 生成唯一键值
         */
        let cacheKey = useCache ? WebServiceCache.generateCacheKey(url: url, params: parameters) : ""
        
        //读取本地缓存
        if useCache {
            let caches:[WebServiceCache] = HHRealmManager.shared.queryModel(model: WebServiceCache.self, filter: " key = '\(cacheKey)' ")
            if caches.count > 0 {
                  let cache = caches[0]
                  if let dataFromString = cache.result.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                      if let jsonData = try? JSON(data: dataFromString) {
                          response(jsonData, true)
                      }
                  }
            }
        }
        
        if useWeb {
            
           // 参数签名
           let authorization = APIParamsManager.configAuthParams(params: parameters)
           log.debug("authorization: \(authorization)")
        
           //用户登录后返回的 token
           let token = "f7a8ae591e4a4bb48f31387a3a0607c1"
           let header: HTTPHeaders = ["timestamp": Date.ts_milliseconds.string,
                                      "token": token,
                                      "Content-Type":"application/json",
                                      "Authorization": authorization
                                     ]
           //POST请求时，body应为json格式数据
           var encoding:ParameterEncoding = URLEncoding.default
           if method == .post || method == .delete {
               encoding = JSONEncoding.default
           }
           Alamofire.request(url,
                             method: method,
                             parameters: parameters,
                             encoding: encoding,
                             headers: header)
            
                .responseJSON {
                    resp in
                    let result = resp.result
                    if result.isSuccess {
                        let json = JSON(result.value!)  //二进制数据转JSON
                        log.debug("接口返回: \(json)")
                        //返回json对象
                        response(json, false)
                        //如果使用缓存，就保存缓存
                        if useCache {
                            let newCache = WebServiceCache()
                            newCache.key = cacheKey
                            newCache.url = url
                            newCache.result = json.rawString()!
                            HHRealmManager.shared.addModel(model: newCache)
                        }
                        
                    } else {
                        
                        log.error("接口返回异常: \(String(describing: result.error))")
                        log.error("result=\(result.description)")
                        let json: JSON =  ["code": "30002","info":"服务器请求失败".localized(),"data":""]
                        //返回json对象
                        response(json, false)
                    }
            }
        }
    }

    
    /// 上传文件接口基础方法  一次性上传一张或多张
    /// 图片（mimeType: "image/jpeg"） 或者音频（mimeType: "audio/AMR"）
    /// 或者其他 只是 mimeType 不一样而已
    /// - Parameters:
    ///   - url: 接口地址
    ///   - parameters: 传入参数  或者  UploadFileModule
    ///   - progress: 上传进度回调
    ///   - response: 完成回调
    internal func uploadFilesOneTime(_ url: String,
                                parameters: [String: Any],
                                progress:((_ percent: Float) -> Void)? = nil,
                                response:@escaping (_ json: JSON, _ isSuccess: Bool) -> Void) {
        
        log.debug("上传文件接口地址: \(url)")
        log.debug("上传文件入参数: \(parameters)")
                
        /// 看后台在哪里抓参数,如果在 url 则 参数拼接到url上
        /// 这里参数默认放在formdata
        /// let toUrl = self.splicingUrlFromParams(parameters: parameters, url: url)
        let toUrl = url
        
       //请求头 按照项目实际需要传
        let token = UserInstance.accessToken ?? ""
        let headers:HTTPHeaders = [
            "Authorization": token,
            "token":token,
            "Content-Type":"multipart/form-data",
            "Origin":self.apiType.apiPublicFileUrl,
            "Referer":self.apiType.apiPublicFileUrl + "/account/auth",
            "appType": "iOS"
        ]
        
        Alamofire.upload(multipartFormData: {
            (multipartFormData) in
            
            /**
             一般后台都在formdata里抓参数 所以默认放在这里
             */
            //添加参数到http body
            for (key, value) in parameters {
                if let str_value = value as? String {
                    
                    multipartFormData.append(str_value.data(using: String.Encoding.utf8)!, withName: key)
                    
                } else if let data_value = value as? UploadFileModule
                {
                    multipartFormData.append(data_value.data,
                                             withName: data_value.name,
                                             fileName: data_value.fileName,
                                             mimeType: data_value.mimeType)
                }
            }
        }, to: toUrl
         , method: .post,
           headers: headers) {
            
            (encodingResult) in

            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress() { (prog) in
                    
                    progress?(Float(prog.fractionCompleted))
                    log.debug("Upload Progress: \(prog.fractionCompleted)")
                    
                    }
                    .responseJSON {
                        resp in
                        
                        let result = resp.result
                        if result.isSuccess {
                            let json = JSON(result.value!)
                            response(json, true)
                        } else {
                            log.error("图片上传失败 result = \(resp.description)")
                            let json: JSON =  ["info": "服务器请求失败".localized(), "code": "30002"]
                            response(json, false)
                        }
                        
                }
            case .failure(let encodingError):
                log.error("上传图片失败\(encodingError)")
                let json: JSON =  ["info": "服务器请求失败".localized(), "code": "30002"]
                response(json, false)
            }
        }
    }
    
    /// 看后台在哪里抓参数,如果在 url 则 参数拼接到url上
    /// - Parameters:
    ///   - parameters: 参数
    ///   - url:  url
    private func splicingUrlFromParams(parameters: [String: Any], url:String) -> String {
        var paramUrl = url
        paramUrl.append("?")
        var dict = [String: Any]()
        for data in parameters {
            if data.value is String {
                dict[data.key] = data.value
            }
        }
        for (index, item) in dict.enumerated() {
            if index == dict.count - 1{
                paramUrl.append("\(item.key)=\(item.value)")
            }else{
                paramUrl.append("\(item.key)=\(item.value)&")
            }
        }
        return paramUrl
    }
    
}
