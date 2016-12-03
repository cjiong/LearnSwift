//
//  ViewController.swift
//  Project 32 - CircleProgressView
//
//  Created by 陈炯 on 16/7/11.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progerssView: ProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var currentProgress = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressLabel.text = "\(currentProgress)%"
        
        addButton.layer.cornerRadius = 30
        minusButton.layer.cornerRadius = 30

    }
    
    @IBAction func addProgress(_ sender: AnyObject) {
        
        let num = Int(arc4random() % 10)
        
        currentProgress += num
        progressLabel.text = "\(currentProgress)%"
        if currentProgress >= 100 {
            
            currentProgress = 100
            progressLabel.text = "\(currentProgress)%"

        }
        
        progerssView.setProgress(progerssView.progress + num, aimated: true, withDuration: 0.50)
    }
    
    @IBAction func minusProgress(_ sender: AnyObject) {
        
        let num = Int(arc4random() % 10)
        
        currentProgress -= num
        progressLabel.text = "\(currentProgress)%"
        if currentProgress <= 0 {
            
            currentProgress = 0
            progressLabel.text = "\(currentProgress)%"

        }
        
        progerssView.setProgress(progerssView.progress - num, aimated: true, withDuration: 0.50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

