//
//  PhotoCenter.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/3.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class PhotoCenter: NSObject {
    
    static let shared = PhotoCenter()
    
    
    override init() {
        super.init()
        chooseImg()
    }
    
    var imgBack:((_ image:UIImage)->())?
    

    private func chooseImg() {
        let alertC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "拍照", style: .default) { (action) in
            let imgPickC = UIImagePickerController()
            imgPickC.delegate = self
            imgPickC.allowsEditing = true
            imgPickC.sourceType = .camera
            Global.shared.topViewController()?.present(imgPickC, animated: true, completion: nil)
        }
        let action1 = UIAlertAction(title: "相册", style: .default) { (action) in
            let imgPickC = UIImagePickerController()
            imgPickC.delegate = self
            imgPickC.allowsEditing = true
            imgPickC.sourceType = .photoLibrary
            Global.shared.topViewController()?.present(imgPickC, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel) { (action) in
            return
        }
        alertC.addAction(action0)
        alertC.addAction(action1)
        alertC.addAction(action2)
        
        Global.shared.topViewController()?.present(alertC, animated: true, completion:nil)
    }

}

extension PhotoCenter:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Global.shared.topViewController()?.dismiss(animated: true, completion: {
            Global.shared.topViewController()?.tabBarController?.tabBar.isHidden = true
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == "public.image" {
            let img = info[UIImagePickerControllerEditedImage] as! UIImage
            self.imgBack!(img)
        }
        
        Global.shared.topViewController()?.dismiss(animated: true, completion: {
            Global.shared.topViewController()?.tabBarController?.tabBar.isHidden = true
        })
    }
}
