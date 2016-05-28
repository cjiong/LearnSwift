//
//  ViewController.swift
//  Project 15 - VideoBackground
//
//  Created by 陈炯 on 16/5/28.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoBackground()
        
        //MARK: 圆角半径
        loginButton.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: 配置
    func setupVideoBackground() {
        
        let videoPath = NSBundle.mainBundle().pathForResource("spotify", ofType: "mp4")
        let videoUrl = NSURL.fileURLWithPath(videoPath!)
        
        videoFrame = view.frame
        fillMode = ScalingMode.ResizeAspectFill
        alwaysRepeat = true
        sound = false
        startTime = 2.0
        alpha = 0.8
        
        contentURL = videoUrl
        view.userInteractionEnabled = false
    }

    
}

