//
//  ViewController.swift
//  StopWatch
//
//  Created by 陈炯 on 16/4/25.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var counter = 0.0
    var timer = NSTimer()
    var isPlaying = false
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //显示时间
        timeLabel.text = String(counter)
        super.viewDidLoad()
        
    }

    //点击开始按钮
    @IBAction func playButtonDidTouch(sender: AnyObject) {
        if(isPlaying) {
            return
        }
        playBtn.enabled = false
        pauseBtn.enabled = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    //点击暂停按钮
    @IBAction func pauseButtonDidTouch(sender: AnyObject) {
        playBtn.enabled = true
        pauseBtn.enabled = false
        //计时器停止
        timer.invalidate()
        isPlaying = false
    }
    
    //点击重置按钮
    @IBAction func resetButtonDidTouch(sender: AnyObject) {
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
        playBtn.enabled = true
        pauseBtn.enabled = true
    }
    
    //更新timer
    func updateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

