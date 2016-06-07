//
//  MiddleViewController.swift
//  Project 20 - BasicGesture
//
//  Created by 陈炯 on 16/6/6.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class MiddleViewController: ViewController {

    
    @IBAction func leftSwipe(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("middleToBottom", sender: .None)
        print("left")
    }
    
    @IBAction func rightSwipe(sender: UISwipeGestureRecognizer) {
        
        self.performSegueWithIdentifier("middleToTop", sender: .None)
        print("right")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
