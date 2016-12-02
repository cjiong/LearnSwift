//
//  BottomViewController.swift
//  Project 20 - BasicGesture
//
//  Created by 陈炯 on 16/6/6.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class BottomViewController: ViewController {

    
    @IBAction func rightSwipe(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
