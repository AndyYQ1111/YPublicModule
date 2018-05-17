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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func chooseImg(_ sender: UIButton) {
        PhotoCenter.shared.imgBack = { (img) in
            self.imgV.image = img
        }
    }
}

