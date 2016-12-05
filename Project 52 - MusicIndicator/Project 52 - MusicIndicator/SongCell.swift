//
//  SongCell.swift
//  Project 52 - MusicIndicator
//
//  Created by 陈炯 on 16/8/30.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct Song {
    
    let name: String
    let artist: String
    init(name: String, artist: String) {
        self.name = name
        self.artist = artist
    }
}

class SongCell: UITableViewCell {

    @IBOutlet weak var namaeLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
