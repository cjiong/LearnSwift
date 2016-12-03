//
//  PositionViewController.swift
//  Project 34 - BasicAnimation
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func upButtonDidTouch(_ sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y - 10, width: frame.size.width, height: frame.size.height)
        squareView.frame = newFrame
    }

    @IBAction func downButtonDidTouch(_ sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y + 10, width: frame.size.width, height: frame.size.height)
        squareView.frame = newFrame
    }
  
    @IBAction func leftButtonDidTouch(_ sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRect(x: frame.origin.x - 10, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        squareView.frame = newFrame
    }
    
    @IBAction func rightButtonDidTouch(_ sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRect(x: frame.origin.x + 10, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        squareView.frame = newFrame
    }
    
}
