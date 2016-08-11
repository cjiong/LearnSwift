//
//  LaunchScreenCountdownView.swift
//  Project 43 - LaunchScreenCountdown
//
//  Created by 陈炯 on 16/8/11.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class LaunchScreenCountdownView: UIView {

    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
    
    let buttonWidth: CGFloat = 40.0
    let buttonHeight: CGFloat = 40.0
    
    var durationTime: Int = 0 {
        didSet {
            skipButton?.setTitle("跳过\n\(durationTime) s", forState: .Normal)
        }
    }
    
    var imageView: UIImageView?
    var skipButton: UIButton?
    
    var timer: NSTimer?
    
    init() {
        super.init(frame: CGRectMake(0, 0, screenWidth, screenHeight))
                
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        imageView?.userInteractionEnabled = true
        self.addSubview(imageView!)
        
        skipButton = UIButton(frame: CGRect(x: screenWidth - buttonWidth - 20.0, y: statusBarHeight + 20.0, width: buttonWidth, height: buttonHeight))
        skipButton?.layer.cornerRadius = buttonWidth / 2
        skipButton?.clipsToBounds = true
        skipButton?.backgroundColor = UIColor(red: 0.64, green: 0.64, blue: 0.64, alpha: 1)
        skipButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        skipButton?.titleLabel?.font = UIFont.systemFontOfSize(10.0)
        skipButton?.titleLabel?.numberOfLines = 2
        skipButton?.titleLabel?.textAlignment = .Center
        skipButton?.addTarget(self, action: "dismissLaunchScreenCountdownView", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(skipButton!)
        
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func showLaunchScreenCountdownView(duration: Int, bgImage: UIImage?) {
        
        let launchView = LaunchScreenCountdownView()
        launchView.durationTime = duration
        launchView.imageView?.image = bgImage
        UIApplication.sharedApplication().delegate?.window!!.addSubview(launchView)
        
    }
    
    func dismissLaunchScreenCountdownView() {
        
        stopTimer()
        UIView.animateWithDuration(0.8, animations: {
            
            self.alpha = 0
            self.transform = CGAffineTransformMakeScale(2.0, 2.0)
            
            }, completion: nil)
        
    }
    
    func startTimer() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerDecrease", userInfo: nil, repeats: true)
    }
    
    func timerDecrease() {
        
        if durationTime == 0 {
            
            dismissLaunchScreenCountdownView()
            
        } else {
            
            durationTime -= 1
        }
    }

    func stopTimer() {
        
        timer?.invalidate()
        timer = nil
    }
    
}




