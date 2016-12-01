//
//  ViewController.swift
//  Project 17 - FaceDetect
//
//  Created by 陈炯 on 16/6/3.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originImgeView: UIImageView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originImgeView.image = UIImage(named: "face")
    }

    @IBAction func detectButtonDidTouch(_ sender: AnyObject) {
        
        let context = CIContext(options: nil)
        let originImage = self.originImgeView.image
        let image = CIImage(cgImage: (originImage?.cgImage)!)
        
        
        //MARK: 设置识别参数
        let param = [CIDetectorAccuracyHigh: CIDetectorAccuracy]
        
        //MARK: 声明CIDetector,设定识别类型
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)
        
        //MARK: 获取识别结果
        let detectResult = faceDetector?.features(in: image)
        let resultView = UIView(frame: self.originImgeView.frame)
        self.view.addSubview(resultView)
        
        for item in detectResult! {
            
            let faceFeature = item as! CIFaceFeature
            let faceView = UIView(frame: faceFeature.bounds)
            faceView.layer.borderWidth = 1
            faceView.layer.borderColor = UIColor.orange.cgColor
            resultView.addSubview(faceView)
            
            //MARK: 左眼
            if faceFeature.hasLeftEyePosition {
                
                let leftEyeView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
                leftEyeView.center = faceFeature.leftEyePosition
                leftEyeView.layer.borderColor = UIColor.red.cgColor
                leftEyeView.layer.borderWidth = 1
                resultView.addSubview(leftEyeView)
            }
            
            //MARK: 右眼
            if faceFeature.hasRightEyePosition {
                
                let rightEyeView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
                rightEyeView.center = faceFeature.rightEyePosition
                rightEyeView.layer.borderColor = UIColor.red.cgColor
                rightEyeView.layer.borderWidth = 1
                resultView.addSubview(rightEyeView)
            }
            
            //MARK: 嘴巴
            if faceFeature.hasMouthPosition {
                
                let mouthView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
                mouthView.center = faceFeature.mouthPosition
                mouthView.layer.borderColor = UIColor.red.cgColor
                mouthView.layer.borderWidth = 1
                resultView.addSubview(mouthView)
            }
        }
        
        //MARK: 变换坐标
        resultView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        if (detectResult?.count)! > 0 {
            
            let faceImage = image.cropping(to: (detectResult?[0].bounds)!)
            let face = UIImage(cgImage: context.createCGImage(faceImage, from: faceImage.extent)!)
            
            self.resultImageView.image = face
            
            let resultText = String(format: "识别人脸数 %i", (detectResult?.count)!)
            
            resultLabel.text = resultText
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

