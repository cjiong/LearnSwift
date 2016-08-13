//
//  SocialItemCell.swift
//  Project 48 - ZoomingIcons
//
//  Created by 陈炯 on 16/8/13.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct SocialItem {
    let image: UIImage?
    let color: UIColor
    let name: String
    let summary: String
}

class SocialItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coloredView: UIView!
    
    var item: SocialItem? {
        didSet {
            if let item = item {
                coloredView.backgroundColor = item.color
                imageView.image = item.image
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coloredView.layer.cornerRadius = bounds.width/2.0
        coloredView.layer.masksToBounds = true
    }

}
