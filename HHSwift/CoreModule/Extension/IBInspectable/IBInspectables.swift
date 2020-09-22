//
//  IBInspectables.swift
//  HHSwift
//
//  Created by hjn on 2020/1/17.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

//MARK: - UIView  Xib IB 基本属性

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    
    @IBInspectable var borderWidh: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let bdColor = self.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: bdColor)
            
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let sdColor = self.layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: sdColor)
            
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
}


//MARK: - UIButton UILabel UITextField  - Xib IB  方便本地化用

extension UIButton {
    
    @IBInspectable var LocalizeTitleInIB: String? {
        
        get {
            return nil
        }
        
        set {
            self.setTitle(newValue?.localized(), for: .normal)
        }
    }
    
}


extension UILabel {
    
    @IBInspectable var LocalizeTextInIB: String? {
        
        get {
            return nil
        }
        
        set {
            self.text = newValue?.localized()
        }
    }
    
}

extension UITextField {
    
    @IBInspectable var LocalizePlaceHolderInIB: String? {
        
        get {
            return nil
        }
        
        set {
            self.placeholder = newValue?.localized()
        }
    }
    
}
