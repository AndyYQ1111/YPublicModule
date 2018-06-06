//
//  Scanner.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/6.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class Scanner: NSObject {
    
    static let shared = Scanner()
    
    private let session = AVCaptureSession()
    
    //视频预览层
    private let videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    private var handleCompleted: ((String) -> ())? = nil
    
    private override init(){
        
        super.init()
        
        AVCaptureDevice.requestAccess(for: .video) { (isSuccess) in
            if isSuccess {
                self.prepare()
            }
            else {
                print("无权访问相机")
            }
        }
    }
    
    private func prepare() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("获取相机发生错误")
            return
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: device) else {
            print("创建设备输入流发生错误")
            return
        }
        
        //创建数据输出流
        let metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //创建设备输出流
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        //会话采集率
        session.sessionPreset = .high
        
        //添加数据输出流到会话对象
        session.addOutput(metadataOutput)
        
        //添加设备输出流到会话对象
        session.addOutput(videoDataOutput)
        
        //添加设备输入流到会话对象
        session.addInput(deviceInput)
        
        //设置数据输出类型
        metadataOutput.metadataObjectTypes = [
            .qr,        //二维码
            .ean13,     //条形码
            .ean8,      //条形码
            .code128    //条形码
        ]
        
        videoPreviewLayer.session = session
        videoPreviewLayer.videoGravity = .resizeAspectFill

    }

    
    func scan(design: @escaping (_ previewLayer: CALayer)->()) -> Self {
        design(videoPreviewLayer)

        startRunning()

        return self
    }

    func completed(aCompleted: @escaping (_ value:String)->()) {
        self.handleCompleted = aCompleted
    }
    
    func startRunning() {
        session.startRunning()
    }
    
    func stopRunning() {
        session.stopRunning()
    }

}

extension Scanner :AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count>0 else {
            return
        }
        
        stopRunning()
        
        guard let stringValue = metadataObjects.first?.value(forKey: "stringValue") as? String else {
            return
        }
        
        handleCompleted?(stringValue)
        
    }
}

extension Scanner: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}

//使用代码
//QRScanner.shared
//    .scan { (previewLayer) in
//
//        let width = UIScreen.main.bounds.size.width - 100
//        previewLayer.frame = CGRect(x: 50, y: 100, width: width, height: width)
//        self.view.layer.insertSublayer(previewLayer, at: 0)
//    }
//    .completed { (qrValue) in
//
//        print(qrValue)
//}

//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//
//    QRScanner.shared.stopRunning()
//}














