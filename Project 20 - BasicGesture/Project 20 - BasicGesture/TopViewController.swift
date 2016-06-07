//
//  TopViewController.swift
//  Project 20 - BasicGesture
//
//  Created by 陈炯 on 16/6/6.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class TopViewController: ViewController {

    
    @IBAction func leftSwipe(sender: UISwipeGestureRecognizer) {
        
        self.performSegueWithIdentifier("topToMiddle", sender: .None)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let swipe = UISwipeGestureRecognizer(target: self, action: "swipe")
        //swipe.direction = UISwipeGestureRecognizerDirection.Left
        //self.view.addGestureRecognizer(swipe)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
