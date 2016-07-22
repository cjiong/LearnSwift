//
//  ScaleViewController.swift
//  Project 34 - BasicAnimation
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var scaleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.scaleImageView.transform = CGAffineTransformMakeScale(5.0, 5.0)
            self.scaleImageView.transform = CGAffineTransformIdentity
            
            }, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
