//
//  ViewController.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/5/16.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

