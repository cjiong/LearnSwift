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
    
    @IBAction func upButtonDidTouch(sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRectMake(frame.origin.x, frame.origin.y - 10, frame.size.width, frame.size.height)
        squareView.frame = newFrame
    }

    @IBAction func downButtonDidTouch(sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRectMake(frame.origin.x, frame.origin.y + 10, frame.size.width, frame.size.height)
        squareView.frame = newFrame
    }
  
    @IBAction func leftButtonDidTouch(sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRectMake(frame.origin.x - 10, frame.origin.y, frame.size.width, frame.size.height)
        squareView.frame = newFrame
    }
    
    @IBAction func rightButtonDidTouch(sender: AnyObject) {
        
        let frame = squareView.frame
        let newFrame = CGRectMake(frame.origin.x + 10, frame.origin.y, frame.size.width, frame.size.height)
        squareView.frame = newFrame
    }
    
}
