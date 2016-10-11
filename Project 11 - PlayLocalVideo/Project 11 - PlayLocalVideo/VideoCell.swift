//
//  VideoCell.swift
//  Project 11 - PlayLocalVideo
//
//  Created by 陈炯 on 16/5/24.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct video {
    
    let image: String
    let title: String
    let source: String
        
}

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoScreenshot: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
