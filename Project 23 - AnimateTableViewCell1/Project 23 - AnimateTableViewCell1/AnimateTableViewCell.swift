//
//  AnimateTableViewCell.swift
//  Project 23 - AnimateTableViewCell1
//
//  Created by 陈炯 on 16/6/11.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class AnimateTableViewCell: UITableViewCell {

    //MARK: 渐变色
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        gradientLayer.frame = self.bounds
        let color1 = UIColor(white: 1.0, alpha: 0.3).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color3 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color4 = UIColor(white: 1.0, alpha: 0.05).CGColor as CGColorRef

        
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.04, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }

}
