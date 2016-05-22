//
//  ViewController.swift
//  Project 09 - MusicPlayer
//
//  Created by 陈炯 on 16/5/22.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    
    var isPlaying: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景模糊效果
        bgImage.image = UIImage(named: "COA")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        bgImage.addSubview(blurEffectView)
        
        
        //歌曲信息
        albumImage.image = UIImage(named: "fun")
    
        songLabel.textColor = UIColor.whiteColor()
        songLabel.text = "All Alone"
        artistLabel.textColor = UIColor.whiteColor()
        artistLabel.text = "Fun."
        
        playButton.setImage(UIImage(named: "Pause"), forState: UIControlState.Normal)
        
        //播放音乐
        playMusic()
        
        //监听按钮点击
        playButton.addTarget(self, action: "playOrPause", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

  
    //播放音乐
    func playMusic() {
        
        let songUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Fun. - All Alone", ofType: "mp3")!)
        
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOfURL: songUrl)
            
            //循环播放
            audioPlayer.numberOfLoops = -1
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch let playError as NSError {
            print(playError)
        }
    }
    
    func playOrPause() {

        if isPlaying {
            audioPlayer.stop()
            playButton.setImage(UIImage(named: "Play"), forState: UIControlState.Normal)
            isPlaying = false
        } else {
            audioPlayer.play()
            playButton.setImage(UIImage(named: "Pause"), forState: UIControlState.Normal)
            isPlaying = true
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

