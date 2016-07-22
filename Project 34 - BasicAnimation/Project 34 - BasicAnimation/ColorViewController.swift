//
//  ColorViewController.swift
//  Project 34 - BasicAnimation
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            
            self.bgView.backgroundColor = UIColor.whiteColor()
            
            }, completion: nil)
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.label.textColor = UIColor(red: 1.00, green: 0.52, blue: 0.07, alpha: 1.00)
            
            }, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
