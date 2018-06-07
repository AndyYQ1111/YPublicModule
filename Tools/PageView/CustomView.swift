//
//  CustomView.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/7.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class CustomView: UIView {
    var contentV: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)    //实现父初始化
        contentV = loadViewFromNib()//从xib中加载视图
        contentV.frame = bounds     //设置约束或者布局
        addSubview(contentV)        //将其添加到自身中
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentV = loadViewFromNib()//从xib中加载视图
        contentV.frame = bounds     //设置约束或者布局
        addSubview(contentV)        //将其添加到自身中
        setupUI()
    }
    
    func loadViewFromNib() -> UIView {
        
        let className = type(of: self)
        let name = NSStringFromClass(className).components(separatedBy: ".").last

        //重点注意，否则使用的时候不会同步显示在IB中，只会在运行中才显示。
        //注意下面的nib加载方式直接影响是否可视化，如果bundle不确切（为nil或者为main）则看不到实时可视化
        
        //方式一
//        let nib = UINib(nibName:String(describing: CircleAdsView.self), bundle: Bundle(for:CircleAdsView.self))//【？？？？】怎么将类名变为字符串：String(describing: MyView.self) Bundle的参数为type(of: self)也可以。
        //方式二
        let nib = UINib(nibName:name!, bundle: Bundle(for:className))
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setupUI() {
        
    }
}
