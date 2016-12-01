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


    @IBAction func changeValue(_ sender: AnyObject) {
        
        let slider = sender as! UISlider
        let value: Float = slider.value
        
        self.filterGaussianBlur(value)
    }
    
    //MARK: 高斯模糊滤镜效果
    func filterGaussianBlur(_ value: Float) {
        
        let context = CIContext(options: nil)
        let cImage = CIImage(cgImage: self.image.cgImage!)
        
        let guassianBlur = CIFilter(name: "CIGaussianBlur")
        guassianBlur?.setValue(cImage, forKey: "inputImage")
        
        let text = String(format: "高斯模糊 Radius : % .2f", value * 10)
        self.label.text = text
        
        guassianBlur!.setValue(value, forKey: "inputRadius")
        let result = guassianBlur?.value(forKey: "outputImage") as! CIImage
        
        let imageRef = context.createCGImage(result, from: CGRect(x: 0, y: 0, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height))
        
        let image = UIImage(cgImage: imageRef!)
        self.imageView.image = image
        
    }
    
    

}

