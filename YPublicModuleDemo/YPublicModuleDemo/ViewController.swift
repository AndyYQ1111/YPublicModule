//
//  ViewController.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/5/16.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageView: PageView!
    
    @IBOutlet weak var imgV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        pageView.titles = ["儿歌","故事","国学","英文"]
        pageView.maxShow = CGFloat(pageView.titles.count)
        
        let tagNames = ["儿歌大全","爱听故事","国学启蒙","英文磨耳朵"]
        var childrenVC:[UIViewController] = [UIViewController]()
        for _ in tagNames {
            let childVC = UIViewController()
            childrenVC.append(childVC)
            self.addChildViewController(childVC)
        }
        
        pageView.childrenVC = childrenVC
        pageView.setupUI()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "历史", target: self, action: #selector(click))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func click(){
        print("click")
    }
    
    @IBAction func chooseImg(_ sender: UIButton) {
        PhotoCenter.shared.imgBack = { (img) in
            self.imgV.image = img
        }
    }
}

