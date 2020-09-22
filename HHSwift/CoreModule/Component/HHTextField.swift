//
//  HHTextField.swift
//  HHSwift
//
//  Created by hjn on 2020/1/17.
//  Copyright © 2020 huang. All rights reserved.
//

import UIKit

//https://www.hangge.com/blog/cache/detail_1907.html
/**
 常用的一些正则表达式：
 */
///中文
let Regular_Expression_Chinese                   = "[\\u4E00-\\u9FA5]"
///英文
let Regular_Expression_English                   = "[A-Za-z]"
///数字
let Regular_Expression_Number                    = "[0-9]"



class HHTextField: UITextField {

    /// 中文输入长度 默认无限制 <= 0 为禁止输入
    var chineseInputLength:Int = Int.max
    
    /// 英文输入长度 默认无限制 <= 0 为禁止输入
    var englishInputLength:Int = Int.max
    
    /// 数字输入长度 默认无限制 <= 0 为禁止输入
    var numberInputLength:Int = Int.max
    
    /// 总长度 默认无限制 超过长度截取
    var totalLength:Int = Int.max
    
    /// 禁止输入的特殊字符 默认无
    var disableInput: String = ""
    
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    
    deinit {
        self.removeNotifications()
    }
    
    func setup() {
        self.addNotifications()
    }
    
    
    func addNotifications() {
        
        NotificationCenter.default.addObserver(self,
        selector:#selector(textFieldChanged),
        name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
        object: self)
    }
    
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func textFieldChanged() {
        
        /// 非markedText才继续往下处理
        guard let _: UITextRange = self.markedTextRange else {
            
            /// 当前光标的位置（后面会对其做修改）
            let cursorPostion = self.offset(from: self.endOfDocument, to: self.selectedTextRange!.end)
            
            var resultStr = self.text ?? ""
            
            /// 中文输入长度 默认无限制 <= 0 为禁止输入
            if  chineseInputLength <= 0 {
                
                resultStr = resultStr.hh_pregReplace(pattern: Regular_Expression_Chinese, with: "")
                
            }else if resultStr.count > chineseInputLength {
                
                resultStr = String(resultStr.prefix(chineseInputLength))
                
            }
            
            /// 英文输入长度 默认无限制 <= 0 为禁止输入
            if  englishInputLength <= 0 {
                
                resultStr = resultStr.hh_pregReplace(pattern: Regular_Expression_English, with: "")
                
            }else if resultStr.count > englishInputLength {
                
                resultStr = String(resultStr.prefix(englishInputLength))
                
            }

            
            /// 数字输入长度 默认无限制 <= 0 为禁止输入
            if  numberInputLength <= 0 {
                
                resultStr = resultStr.hh_pregReplace(pattern: Regular_Expression_Number, with: "")
                
            }else if resultStr.count > numberInputLength {
                
                resultStr = String(resultStr.prefix(numberInputLength))
                
            }
            
            
            /// 总长度 默认无限制 超过长度截取
            if resultStr.count > totalLength {
                
                resultStr = String(resultStr.prefix(totalLength))
                
            }
                        
  
            /// 禁止输入的特殊字符 默认无
            if disableInput.count > 0 {
                let pattern = "[" + disableInput + "]"
                resultStr = resultStr.hh_pregReplace(pattern: pattern, with: "")
            }
        
        
            self.text = resultStr
             
            /// 让光标停留在正确位置
            let targetPostion = self.position(from: self.endOfDocument,
                                                   offset: cursorPostion)!
            self.selectedTextRange = self.textRange(from: targetPostion,
                                                              to: targetPostion)
            return
        }
        
        

    }
}


extension String {
    // 使用正则表达式替换
    func hh_pregReplace(pattern: String,
                        with: String,
                        options: NSRegularExpression.Options = []) -> String {
        
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self,
                                              options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
}
