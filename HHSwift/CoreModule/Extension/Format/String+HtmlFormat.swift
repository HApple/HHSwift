//
//  String+HtmlFormat.swift
//  HHSwift
//
//  Created by hjn on 2020/1/6.
//  Copyright © 2020 huang. All rights reserved.
//

import Foundation

extension String {
    
    func htmlFormat() -> String {
        let content = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\"><style type=\"text/css\">body {font-family: PingFang-SC-regular!important;color:2a4860!important;margin-left:15px;margin-right:15px;} a{word-break: break-all;} *{word-break: break-all;}</style></head><body><script type='text/javascript'>window.onload =function(){var $img = document.getElementsByTagName('img');for(var p in  $img){$img[p].style.width = '100%';$img[p].style.height ='auto';}}</script>" + self + "</body></html>"
        return content
    }
}
