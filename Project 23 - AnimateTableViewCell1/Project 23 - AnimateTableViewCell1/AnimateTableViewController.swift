//
//  AnimateTableViewController.swift
//  Project 23 - AnimateTableViewCell1
//
//  Created by 陈炯 on 16/6/11.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class AnimateTableViewController: UITableViewController {

    var data = ["Ferrari", "Lamborghini", "Aston Martin", "Porsche", "Audi", "Benz", "BMW", "Honda", "Toyota", "Land Rover", "Bugatti", "Volkswagen", "Alfa_Romeo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.registerClass(AnimateTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        animate()
    }
    
    //MARK: 动画方法
    func animate() {
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                
                cell.transform = CGAffineTransformMakeTranslation(0, 0)
                
                }, completion: nil)
            
            index += 1
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = data[indexPath.row] 
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.textAlignment = .Left
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    
    func colorforIndex(index: Int) -> UIColor {
        
        let itemCount = data.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.7
        return UIColor(red: 0.6, green: color, blue: 0.8, alpha: 1.0)
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor =  colorforIndex(indexPath.row)
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        animate()
    }
    
}
