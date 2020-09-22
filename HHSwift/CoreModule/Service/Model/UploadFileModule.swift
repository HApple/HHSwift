//
//  UploadFileModule.swift
//  HHSwift
//
//  Created by hjn on 2020/1/7.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

/**
 对应 Alamofire MulipartFormData
 */
/// Creates a body part from the data and appends it to the multipart form data object.
///
/// The body part data will be encoded using the following format:
///
/// - `Content-Disposition: form-data; name=#{name}; filename=#{filename}` (HTTP Header)
/// - `Content-Type: #{mimeType}` (HTTP Header)
/// - Encoded file data
/// - Multipart form boundary
///
/// - parameter data:     The data to encode into the multipart form data.
/// - parameter name:     The name to associate with the data in the `Content-Disposition` HTTP header.
/// - parameter fileName: The filename to associate with the data in the `Content-Disposition` HTTP header.
/// - parameter mimeType: The MIME type to associate with the data in the `Content-Type` HTTP header.


class UploadFileModule: NSObject {
    
    var data: Data!
    var name: String!
    var fileName: String!
    var mimeType: String!
    
    /// 上传文件 model
    /// - Parameters:
    ///   - data:  文件数据
    ///   - name: 文件名
    ///   - fileName: 文件名.xx
    ///   - mimeType: 类型
    convenience init(data: Data, name: String, fileName: String, mimeType: String) {
        self.init()
        self.data = data
        self.fileName = fileName
        self.name = name
        self.mimeType = mimeType
    }
}
