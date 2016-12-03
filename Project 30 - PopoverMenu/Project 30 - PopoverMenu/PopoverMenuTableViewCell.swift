//
//  PopoverMenuTableViewCell.swift
//  Project 30 - PopoverMenu
//
//  Created by 陈炯 on 16/7/10.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct MenuItem {
    
    var picture: String!
    var name: String!
    
}

class PopoverMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
