//
//  Global.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class Global: NSObject {
    static let shared = Global()
}

extension Global {
    
    /// 获取最上层的Viewcontroller
    ///
    /// - Parameter topVC: 最上层的Viewcontroller
    /// - Returns: 最上层的Viewcontroller
    func topViewController(topVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = topVC as? UINavigationController {
            return topViewController(topVC: nav.visibleViewController)
        }
        if let tab = topVC as? UITabBarController {
            return topViewController(topVC: tab.selectedViewController)
        }
        if let presented = topVC?.presentedViewController {
            return topViewController(topVC: presented)
        }
        return topVC
    }
}
