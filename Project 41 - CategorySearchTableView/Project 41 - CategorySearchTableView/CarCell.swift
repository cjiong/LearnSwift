//
//  CarCell.swift
//  Project 41 - CategorySearchTableView
//
//  Created by 陈炯 on 16/7/31.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct Car {
    
    let country: String
    let brand: String
    
    init(country: String, brand: String) {
        self.country = country
        self.brand = brand
    }
}

class CarCell: UITableViewCell {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
