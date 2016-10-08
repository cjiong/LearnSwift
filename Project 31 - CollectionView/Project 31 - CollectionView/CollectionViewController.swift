//
//  CollectionViewController.swift
//  Project 31 - CollectionView
//
//  Created by 陈炯 on 16/7/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    let wheel = [
        ["name": "1", "pic": "wheel1"],
        ["name": "2", "pic": "wheel2"],
        ["name": "3", "pic": "wheel3"],
        ["name": "4", "pic": "wheel4"],
        ["name": "5", "pic": "wheel5"],
        ["name": "6", "pic": "wheel6"],
        ["name": "7", "pic": "wheel7"],
        ["name": "8", "pic": "wheel8"],
        ["name": "9", "pic": "wheel9"],
        ["name": "10", "pic": "wheel10"],
        ["name": "11", "pic": "wheel11"],
        ["name": "12", "pic": "wheel12"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wheel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        (cell.contentView.viewWithTag(1) as! UIImageView).image = UIImage(named: wheel[(indexPath as NSIndexPath).item]["pic"]!)
        (cell.contentView.viewWithTag(2) as! UILabel).text = wheel[(indexPath as NSIndexPath).item]["name"]
        
        return cell
    }
    

}










