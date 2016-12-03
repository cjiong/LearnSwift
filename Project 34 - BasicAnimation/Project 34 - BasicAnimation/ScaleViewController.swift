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

        UIView.animate(withDuration: 2.0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self.scaleImageView.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            self.scaleImageView.transform = CGAffineTransform.identity
            
            }, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
