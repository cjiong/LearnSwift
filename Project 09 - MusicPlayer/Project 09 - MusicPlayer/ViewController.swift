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
    
    @IBOutlet weak var playButon: CustomButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    
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
        albumImage.layer.cornerRadius = 100
        
        songLabel.textColor = UIColor.grayColor()
        songLabel.text = "All Alone"
        artistLabel.textColor = UIColor.grayColor()
        artistLabel.text = "Fun."
        
        playButon.setImage(UIImage(named: "Play"), forState: UIControlState.Normal)
        
    }

    //播放音乐
    @IBAction func playMusicButtonDidTouch(sender: CustomButton) {
        
        let song = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Fun. - All Alone", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOfURL: song)
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch let playError as NSError {
            print(playError)
        }
        if sender.isPlay {
            audioPlayer.play()
        } else {
            audioPlayer.stop()
        }
    }
    
    //点击播放(暂停)按钮的方法
    func onPlay(button: CustomButton) {
        if button.isPlay {
            audioPlayer.play()
        } else {
            audioPlayer.stop()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

