//
//  HHLoggerManager.swift
//  HHSwift
//
//  Created by hjn on 2020/1/7.
//  Copyright © 2020 huang. All rights reserved.
//

/**
 XCGLogger 使用详情介绍 https://www.hangge.com/blog/cache/detail_1418.html
 */

import Foundation
import XCGLogger


/**
 使用方法
         log.verbose("一条verbose级别消息：程序执行时最详细的信息。")
         log.debug("一条debug级别消息：用于代码调试。")
         log.info("一条info级别消息：常用与用户在console.app中查看。")
         log.warning("一条warning级别消息：警告消息，表示一个可能的错误。")
         log.error("一条error级别消息：表示产生了一个可恢复的错误，用于告知发生了什么事情。")
         log.severe("一条severe error级别消息：表示产生了一个严重错误。程序可能很快会奔溃。")
 */
let log = XCGLogger.default

class HHLoggerManager: NSObject {
    
    class func configLogger() {
        
        let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let logURL = cachePath.appendingPathComponent("log.txt")
        
        //日志对象设置
        log.setup(level: .debug,
                  showLogIdentifier: true,
                  showFunctionName: true,
                  showThreadName: true,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  showDate: true,
                  writeToFile: logURL,
                  fileLevel: .debug)
        
        
        // Add colour (using the ANSI format) to our file log, you can see the colour when `cat`ing or `tail`ing the file in Terminal on macOS
        // This is mostly useful when testing in the simulator, or if you have the app sending you log files remotely
        if let fileDestination: FileDestination = log.destination(withIdentifier: XCGLogger.Constants.fileDestinationIdentifier) as? FileDestination {
            let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
            ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
            ansiColorLogFormatter.colorize(level: .debug, with: .black)
            ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
            ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
            ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
            ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
            fileDestination.formatters = [ansiColorLogFormatter]
        }
        
        // You can also change the labels for each log level, most useful for alternate languages, French, German etc, but Emoji's are more fun
        //    log.levelDescriptions[.verbose] = "🗯"
        //    log.levelDescriptions[.debug] = "🔹"
        //    log.levelDescriptions[.info] = "ℹ️"
        //    log.levelDescriptions[.warning] = "⚠️"
        //    log.levelDescriptions[.error] = "‼️"
        //    log.levelDescriptions[.severe] = "💣"
        // Alternatively, you can use emoji to highlight log levels (you probably just want to use one of these methods at a time).
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
        emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
        log.formatters = [emojiLogFormatter]
    }
}
