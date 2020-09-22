//
//  HHUserManager.swift
//  HHSwift
//
//  Created by hjn on 2020/1/10.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyJSON
import TimedSilver

let UserInstance = UserManager.shared


private let kAccessToken = "kHH_accessToken"
private let kUserId      = "kHH__userId"
private let kPassword    = "kHH__password"

class UserManager: NSObject {
    
    static let shared = UserManager()
    
    let HHKeychain = Keychain(service: Bundle.ts_bundleIdentifier)
    
    var accessToken: String? {
        get { return UserDefaults.ts_stringForKey(kAccessToken, defaultValue: "这是我的 AccessToken") }
        set (newValue) { UserDefaults.ts_setString(kAccessToken, value: newValue) }
    }
    var userId: String? {
        get { return UserDefaults.ts_stringForKey(kUserId, defaultValue: "") }
        set (newValue) { UserDefaults.ts_setString(kUserId, value: newValue) }
    }
    ///密码, 存在 keychain
    var password: String?  {
        get { return  HHKeychain[kPassword] ?? "" }
        set (newValue) { HHKeychain[kPassword] = newValue }
    }
    
    fileprivate override init() {
         super.init()
     }
     
     func readAllData() {
         
         self.userId = UserDefaults.ts_stringForKey(kUserId, defaultValue: "")
         self.password = HHKeychain[kPassword] ?? ""
     }
     
     /**
      登录成功
      - parameter result: 登录成功后传进来的字典
      */
     func userLoginSuccess(_ result: JSON) {
         
         self.password = result["password"].stringValue
         self.userId = result["user_id"].stringValue
         
     }
     
     /**
      退出登录
      */
     func userLogout() {
         self.accessToken = ""
         self.password = ""
         self.userId = ""
     }
     
     func resetAccessToken(_ token: String) {
         UserDefaults.ts_setString(kAccessToken, value: token)
         if token.count > 0 {
             print("token success")
         } else {
             self.userLogout()
         }
     }
}
