//
//  UIBarButtonItem+Extension.swift
//  百味迹忆
//
//  Created by YueAndy on 2017/6/16.
//  Copyright © 2017年 YueAndy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title : String?,imageName: String?, titleSize : CGFloat = 15,target: Any? , action: Selector) {
        let btn = UIButton(title: title, imageName: imageName, titleSize: titleSize)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
    convenience init(title : String? = "", titleSize : CGFloat = 15,target: Any? , action: Selector) {
        self.init(title: title, imageName: nil, titleSize: titleSize, target: Any?.self, action: action)
    }
    
    convenience init(imageName: String? = "", titleSize : CGFloat = 15,target: Any? , action: Selector) {
        self.init(title: nil, imageName: imageName, titleSize: titleSize, target: Any?.self, action: action)
    }
}
