//
//  BaseViewController.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

/************************  屏幕尺寸  ***************************/
// 屏幕宽度

let KScreenW = UIScreen.main.bounds.size.width

// 屏幕高度

let KScreenH = UIScreen.main.bounds.size.height

// iphone X

let isIphoneX = KScreenH == 812 ? true : false

// navigationBarHeight

let KNavBarH : CGFloat = isIphoneX ? 88 : 64

// tabBarHeight

let KTabBarH : CGFloat = isIphoneX ? 49 + 34 : 49

//let rgba(r,g,b,a)

//蓝色渐变色

let kBlueGradientColors = [UIColor(r: 70.0, g: 137, b: 247).cgColor,UIColor(r: 52, g: 131, b: 237).cgColor]


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white

        //设置导航栏背景图
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(gradientColors: kBlueGradientColors, size: CGSize(width: KScreenW, height: KNavBarH)), for: .default)
        
        self.navigationController?.navigationBar.barStyle = .black;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


