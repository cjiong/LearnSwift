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

    @IBAction func detectButtonDidTouch(sender: AnyObject) {
        
        let context = CIContext(options: nil)
        let originImage = self.originImgeView.image
        let image = CIImage(CGImage: (originImage?.CGImage)!)
        
        
        //MARK: 设置识别参数
        let param = [CIDetectorAccuracyHigh: CIDetectorAccuracy]
        
        //MARK: 声明CIDetector,设定识别类型
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)
        
        //MARK: 获取识别结果
        let detectResult = faceDetector.featuresInImage(image)
        let resultView = UIView(frame: self.originImgeView.frame)
        self.view.addSubview(resultView)
        
        for item in detectResult {
            
            let faceFeature = item as! CIFaceFeature
            let faceView = UIView(frame: faceFeature.bounds)
            faceView.layer.borderWidth = 1
            faceView.layer.borderColor = UIColor.orangeColor().CGColor
            resultView.addSubview(faceView)
            
            //MARK: 左眼
            if faceFeature.hasLeftEyePosition {
                
                let leftEyeView = UIView(frame: CGRectMake(0, 0, 5, 5))
                leftEyeView.center = faceFeature.leftEyePosition
                leftEyeView.layer.borderColor = UIColor.redColor().CGColor
                leftEyeView.layer.borderWidth = 1
                resultView.addSubview(leftEyeView)
            }
            
            //MARK: 右眼
            if faceFeature.hasRightEyePosition {
                
                let rightEyeView = UIView(frame: CGRectMake(0, 0, 5, 5))
                rightEyeView.center = faceFeature.rightEyePosition
                rightEyeView.layer.borderColor = UIColor.redColor().CGColor
                rightEyeView.layer.borderWidth = 1
                resultView.addSubview(rightEyeView)
            }
            
            //MARK: 嘴巴
            if faceFeature.hasMouthPosition {
                
                let mouthView = UIView(frame: CGRectMake(0, 0, 10, 5))
                mouthView.center = faceFeature.mouthPosition
                mouthView.layer.borderColor = UIColor.redColor().CGColor
                mouthView.layer.borderWidth = 1
                resultView.addSubview(mouthView)
            }
        }
        
        //MARK: 变换坐标
        resultView.transform = CGAffineTransformMakeScale(1, -1)
        
        if detectResult.count > 0 {
            
            let faceImage = image.imageByCroppingToRect(detectResult[0].bounds)
            let face = UIImage(CGImage: context.createCGImage(faceImage, fromRect: faceImage.extent))
            
            self.resultImageView.image = face
            
            let resultText = String(format: "识别人脸数 %i", detectResult.count)
            
            resultLabel.text = resultText
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

