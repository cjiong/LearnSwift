//
//  ViewController.swift
//  Project 33 - SpotlightSearch
//
//  Created by 陈炯 on 16/7/13.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UITableViewController {

    var data = [
        scenery(name: "City", image: "4-1"),
        scenery(name: "Mountain", image: "4-2"),
        scenery(name: "Field", image: "4-3"),
        scenery(name: "Tree", image: "4-4"),
        scenery(name: "Snow", image: "4-5"),
        scenery(name: "Harbor", image: "4-6")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchContent()
    }
    
    //MARK: 设置搜索内容
    func setupSearchContent() {
        
        var searchItems = [CSSearchableItem]()
        
        for i in 0...(data.count - 1) {
            
            let scenery = data[i].name as String
            
            let searchItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            searchItemAttributeSet.title = scenery
            searchItemAttributeSet.contentDescription = "This is \(scenery)"
            searchItemAttributeSet.thumbnailData = UIImagePNGRepresentation(UIImage(named: "pic\(i + 1)")!)
            
            let searchItem = CSSearchableItem(uniqueIdentifier: "scenery\(i)", domainIdentifier: "scenery", attributeSet: searchItemAttributeSet)
            searchItems.append(searchItem)
            
            CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchItem], completionHandler: { (error) -> Void in
                
                if error != nil {
                    print(error?.localizedDescription)
                }
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! SceneryCell
        
        cell.sceneryNameLabel.text = data[indexPath.row].name
        cell.sceneryImageView.image = UIImage(named: data[indexPath.row].image)
        
        return cell
    }
    

}

