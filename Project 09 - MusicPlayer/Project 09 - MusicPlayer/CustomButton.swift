//
//  CustomButton.swift
//  Project 09 - MusicPlayer
//
//  Created by 陈炯 on 16/5/22.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var isPlay: Bool = true
    let imgPlay: UIImage = UIImage(named: "Play")!
    let imgPause: UIImage = UIImage(named: "Pause")!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: "onClick", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func onClick() {
        isPlay = !isPlay
        if isPlay {
            self.setImage(imgPause, forState: UIControlState.Normal)
        } else {
            self.setImage(imgPlay, forState: UIControlState.Normal)
        }
    }
    
    func onPlay() {
        isPlay = true
        self.setImage(imgPause, forState: UIControlState.Normal)
    }
}

