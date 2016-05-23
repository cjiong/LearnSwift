//
//  ViewController.swift
//  Project 10 - RandomGradientColorMusic
//
//  Created by 陈炯 on 16/5/23.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    //渐变色layer
    var gradientColorLayer = CAGradientLayer()
    
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blueColor()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBAction func playButtonDidTouch(sender: AnyObject) {
        
        //播放音乐
        let songUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Alan Walker - Fade", ofType: "mp3")!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: songUrl)
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch let playError as NSError {
            print(playError)
        }
        
        //MARK: 启动计时器，控制每0.2秒执行一次randomColor方法
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "randomColor", userInfo: nil, repeats: true)
        
        
        
        //渐变色
        gradientColorLayer.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4).CGColor as CGColorRef
        let color3 = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.3).CGColor as CGColorRef
        let color4 = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.3).CGColor as CGColorRef
        let color5 = UIColor(white: 0.4, alpha: 0.5).CGColor as CGColorRef
        
        gradientColorLayer.colors = [color1, color2, color3, color4, color5]
        gradientColorLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientColorLayer.startPoint = CGPointMake(0.0, 0.0)
        gradientColorLayer.endPoint = CGPointMake(1.0, 1.0)
        self.view.layer.addSublayer(gradientColorLayer)
    }
    
    //随机颜色
    func randomColor() {
        
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

