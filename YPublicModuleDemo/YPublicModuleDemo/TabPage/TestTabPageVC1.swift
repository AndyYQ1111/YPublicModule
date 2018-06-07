//
//  TestTabPageVC1.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/6.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class TestTabPageVC1: BaseViewController {
    
    @IBOutlet weak var pageV: PageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //子视图名
        pageV.titles = ["儿歌","故事","国学","英文"]
        
        //一屏最多显示的页数
        pageV.maxShow = CGFloat(pageV.titles.count)
        
        //子视图控制器组
        var childrenVC:[UIViewController] = [UIViewController]()
        for _ in pageV.titles {
            let childVC = UIViewController()
            childrenVC.append(childVC)
            self.addChildViewController(childVC)
        }
        
        pageV.childrenVC = childrenVC
        
        pageV.reloadData()
    }
}
