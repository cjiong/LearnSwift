//
//  OpacityViewController.swift
//  Project 34 - BasicAnimation
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 2.0
        animation.fromValue = 1.0
        animation.toValue = 0.0
        self.imageView.layer.add(animation, forKey: "Image-opacity")
        self.imageView.alpha = 0.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
