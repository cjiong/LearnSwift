//
//  ViewController.swift
//  Project 43 - LaunchScreenCountdown
//
//  Created by 陈炯 on 16/7/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        
        LaunchScreenCountdownView.showLaunchScreenCountdownView(3, bgImage: UIImage(named: "Aurora"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

