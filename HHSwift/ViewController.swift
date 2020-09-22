//
//  ViewController.swift
//  HHSwift
//
//  Created by hjn on 2020/1/3.
//  Copyright © 2020 huang. All rights reserved.
//

import UIKit
import SwifterSwift

class ViewController: UIViewController {
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        log.verbose("一条verbose级别消息：程序执行时最详细的信息。")
//        log.debug("一条debug级别消息：用于代码调试。")
//        log.info("一条info级别消息：常用与用户在console.app中查看。")
//        log.warning("一条warning级别消息：警告消息，表示一个可能的错误。")
//        log.error("一条error级别消息：表示产生了一个可恢复的错误，用于告知发生了什么事情。")
//        log.severe("一条severe error级别消息：表示产生了一个严重错误。程序可能很快会奔溃。")
        
        
        let tf = HHTextField(frame: CGRect(x: 40, y: 100, width: 100, height: 40))
        //tf.keyboardType = .decimalPad
        tf.chineseInputLength = 5
        tf.englishInputLength = 4
        tf.disableInput = "."
        self.view.addSubview(tf)
        
        
    }
        
        
}


