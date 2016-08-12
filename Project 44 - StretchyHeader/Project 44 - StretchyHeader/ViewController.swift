//
//  ViewController.swift
//  Project 44 - StretchyHeader
//
//  Created by 陈炯 on 16/7/24.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let tableHeaderHeight: CGFloat = 250
    
    var headerView: UIView!
    
    let data = [
        Scenery(image: "pic1", name: "City", summary: "A large and densely populated urban area", nameColor: UIColor.redColor()),
                Scenery(image: "pic2", name: "Mountain", summary: "A land mass that projects well above its surroundings", nameColor: UIColor.brownColor()),
                Scenery(image: "pic3", name: "Field", summary: "A piece of land cleared of grass and usually enclosed", nameColor: UIColor.greenColor()),
                Scenery(image: "pic4", name: "Tree", summary: "A figure that branches from a single root", nameColor: UIColor.purpleColor()),
                Scenery(image: "pic5", name: "Snow", summary: "Precipitation falling from clouds in the form of ice crystals", nameColor: UIColor.blueColor()),
                Scenery(image: "pic6", name: "Harbor", summary: "A sheltered port where ships can take on", nameColor: UIColor.orangeColor())
               ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        var rect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -tableHeaderHeight {
            rect.origin.y = tableView.contentOffset.y
            rect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = rect
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    //MARK: tableview datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! SceneryCell
        
        cell.sceneImage.image = UIImage(named: data[indexPath.row].image)
        cell.nameLabel.text = data[indexPath.row].name
        cell.nameLabel.textColor = data[indexPath.row].nameColor
        cell.summaryLabel.text = data[indexPath.row].summary
        
        return cell
    }
    
    //MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

