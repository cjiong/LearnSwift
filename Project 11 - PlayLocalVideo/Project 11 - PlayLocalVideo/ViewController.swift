//
//  ViewController.swift
//  Project 11 - PlayLocalVideo
//
//  Created by 陈炯 on 16/5/23.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var videoTableView: UITableView!
    
    var data = [
        
        video(image: "videoScreenshot01", title: "Tim Duncan", source: "Weibo - 0:30"),
        video(image: "videoScreenshot02", title: "Tracy McGrady", source: "YouTube - 8:30"),
        video(image: "videoScreenshot03", title: "Kobe Bryant", source: "Instgram - 9:30"),
        video(image: "videoScreenshot04", title: "James Harden", source: "Viemo - 6:30"),
        video(image: "videoScreenshot05", title: "Kevin Durant", source: "Facebook - 9:30"),
        video(image: "videoScreenshot06", title: "LeBron James", source: "Twitter - 2:30")
    
    ]
    
    //MARK: key
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 设置代理委托和数据源
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playButtonDidTouch(sender: AnyObject) {
        
        //MARK: 播放视频
        let path = NSBundle.mainBundle().pathForResource("1", ofType: "mp4")
        
        playerView = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        
        playViewController.player = playerView
        
        self.presentViewController(playViewController, animated: true) {
        
            self.playViewController.player?.play()
        }
        
    }
    
    //MARK: 单元格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //MARK: 单元格行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
        
    //MARK: 单元格样式
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = videoTableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell
        let video = data[indexPath.row]
        
        cell.videoScreenshot.image = UIImage(named: video.image)
        cell.videoSourceLabel.text = video.source
        cell.videoTitleLabel.text = video.title
        
        return cell
    }
}

