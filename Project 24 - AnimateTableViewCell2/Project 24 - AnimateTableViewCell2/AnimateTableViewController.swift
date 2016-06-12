//
//  AnimateTableViewController.swift
//  Project 24 - AnimateTableViewCell2
//
//  Created by 陈炯 on 16/6/12.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class AnimateTableViewController: UITableViewController {
    
    var data = ["Ferrari", "Lamborghini", "Aston Martin", "Porsche", "Audi", "Benz", "BMW", "Honda", "Toyota", "Land Rover", "Bugatti", "Volkswagen", "Alfa Romeo", "Flat", "Lexus", "Ford", "Nissan", "Bentley", "Jeep", "Rolls Royce", "Lincoin", "Volvo", "Maserati", "Infiniti", "Dodge", "Subaru", "Jaguar", "Maybach"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .Left
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20)

        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    
    func colorforIndex(index: Int) -> UIColor {
        
        let itemCount = data.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.7
        return UIColor(red: color, green: 0.5, blue: 1.0, alpha: 1.0)
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor =  colorforIndex(indexPath.row)
        
        //MARK: 动画
        cell.layer.transform = CATransform3DMakeScale(0.5, 1.0, 1.0)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        })
    }

}
