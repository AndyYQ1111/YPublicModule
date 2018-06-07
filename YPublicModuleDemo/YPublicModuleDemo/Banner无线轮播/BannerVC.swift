//
//  BannerVC.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/6.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class BannerVC: BaseViewController {

    private var circleAd:CircleAdsView = {
        let circleAd = CircleAdsView.init(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenW * 9 / 16))
        return circleAd;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(circleAd)
        var dataArr = [String]()
        dataArr.append("https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2922830890,4204508299&fm=15&gp=0.jpg")
        dataArr.append("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=145271610,3306188424&fm=15&gp=0.jpg")
        dataArr.append("https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=751663760,645358268&fm=27&gp=0.jpg")
        dataArr.append("https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2250084471,2057294866&fm=15&gp=0.jpg")
        circleAd.adsArr = dataArr
    }
}
