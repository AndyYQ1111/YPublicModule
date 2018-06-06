//
//  BaseTabBarController.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/1.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addChildVcs(childVcs:[UIViewController]) {
        for childVc in childVcs {
            self.addChildViewController(childVc)
        }
    }

}
