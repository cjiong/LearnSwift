//
//  DrawerCell.swift
//  Project 49 - ElasticDrawer
//
//  Created by 陈炯 on 16/8/23.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct Player {
    
    let name: String
    let pic: String
    
    init(name: String, pic: String) {
        
        self.name = name
        self.pic = pic
    }
}

class DrawerCell: UITableViewCell {
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
