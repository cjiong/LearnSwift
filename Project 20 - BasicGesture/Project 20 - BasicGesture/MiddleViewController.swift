//
//  MiddleViewController.swift
//  Project 20 - BasicGesture
//
//  Created by 陈炯 on 16/6/6.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class MiddleViewController: ViewController {

    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "middleToBottom", sender: .none)
        print("left")
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        
        self.performSegue(withIdentifier: "middleToTop", sender: .none)
        print("right")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
