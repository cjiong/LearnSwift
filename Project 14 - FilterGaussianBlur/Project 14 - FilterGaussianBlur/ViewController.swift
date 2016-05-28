//
//  ViewController.swift
//  Project 14 - FilterGaussianBlur
//
//  Created by 陈炯 on 16/5/28.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var image: UIImage = UIImage(named: "audi")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = self.image
        label.text = ""

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func changeValue(sender: AnyObject) {
        
        let slider = sender as! UISlider
        let value: Float = slider.value
        
        self.filterGaussianBlur(value)
    }
    
    //MARK: 高斯模糊滤镜效果
    func filterGaussianBlur(value: Float) {
        
        let context = CIContext(options: nil)
        let cImage = CIImage(CGImage: self.image.CGImage!)
        
        let guassianBlur = CIFilter(name: "CIGaussianBlur")
        guassianBlur?.setValue(cImage, forKey: "inputImage")
        
        let text = String(format: "高斯模糊 Radius : % .2f", value * 10)
        self.label.text = text
        
        guassianBlur!.setValue(value, forKey: "inputRadius")
        let result = guassianBlur?.valueForKey("outputImage") as! CIImage
        
        let imageRef = context.createCGImage(result, fromRect: CGRectMake(0, 0, self.imageView.image!.size.width, self.imageView.image!.size.height))
        
        let image = UIImage(CGImage: imageRef)
        self.imageView.image = image
        
    }
    
    

}

