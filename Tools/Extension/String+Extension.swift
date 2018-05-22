//
//  String+Extension.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/30.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

extension String {
    //计算文字Size
    func size(font : UIFont , maxSize : CGSize) -> CGSize {
        return self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
    
    func numFormat() -> String {
        let num = (self as NSString).floatValue
        var newStr = self
        if num > 10000 {
            newStr = String(format: "%.2f",num/10000)
        }
        return newStr
    }
}
