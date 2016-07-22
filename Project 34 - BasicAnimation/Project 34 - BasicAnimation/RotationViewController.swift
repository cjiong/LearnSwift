//
//  RotationViewController.swift
//  Project 34 - BasicAnimation
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var rotationImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animateWithDuration(10.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.rotationImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            
            }, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
