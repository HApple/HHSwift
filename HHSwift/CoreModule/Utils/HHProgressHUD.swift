//
//  HHPfogressHud.swift
//  HHSwift
//
//  Created by hjn on 2020/1/9.
//  Copyright © 2020 huang. All rights reserved.
//


/// 对 HUD 层进行一次封装

import Foundation
import SVProgressHUD

class HHProgressHUD: NSObject {
    
    class func initHUD() {
        SVProgressHUD.setBackgroundColor(UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7 ))
         SVProgressHUD.setForegroundColor(UIColor.white)
         SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14))
         SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
    }
    
    //成功
    class func showSuccessWithStatus(_ string: String) {
        self.HHProgressHUDShow(.success, status: string)
    }
    
    //失败 ，NSError
    class func showErrorWithObject(_ error: NSError) {
        self.HHProgressHUDShow(.errorObject, status: nil, error: error)
    }
    
    //失败，String
    class func showErrorWithStatus(_ string: String) {
        self.HHProgressHUDShow(.errorString, status: string)
    }
    
    //转菊花
    class func showWithStatus(_ string: String) {
        self.HHProgressHUDShow(.loading, status: string)
    }
    
    //警告
    class func showWarningWithStatus(_ string: String) {
        self.HHProgressHUDShow(.info, status: string)
    }
    
    //dismiss消失
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    //私有方法
    fileprivate class func HHProgressHUDShow(_ type: HUDType, status: String? = nil, error: NSError? = nil) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
            break
        case .errorObject:
            guard let newError = error else {
                SVProgressHUD.showError(withStatus: "Error:出错拉")
                return
            }
            
            if newError.localizedFailureReason == nil {
                SVProgressHUD.showError(withStatus: "Error:出错拉")
            } else {
                SVProgressHUD.showError(withStatus: error!.localizedFailureReason)
            }
            break
        case .errorString:
            SVProgressHUD.showError(withStatus: status)
            break
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
            break
        case .loading:
            SVProgressHUD.show(withStatus: status)
            break
        }
    }
    
    fileprivate enum HUDType: Int {
        case success, errorObject, errorString, info, loading
    }
}
