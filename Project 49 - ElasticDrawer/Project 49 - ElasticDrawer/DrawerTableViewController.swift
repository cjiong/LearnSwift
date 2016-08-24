//
//  DrawerTableViewController.swift
//  Project 49 - ElasticDrawer
//
//  Created by 陈炯 on 16/8/23.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class DrawerTableViewController: UITableViewController {
    
    let data = [
        Player(name: "Tracy McGrady", pic: "1"),
        Player(name: "Kobe Bryant", pic: "2"),
        Player(name: "Michael Jordan", pic: "3"),
        Player(name: "LeBron James", pic: "4"),
        Player(name: "Dwight Howard", pic: "5"),
        Player(name: "Jeremy Lin", pic: "6"),
        Player(name: "Kevin Durant", pic: "7"),
        Player(name: "Stephen Curry", pic: "8")
    ]
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! DrawerCell

        cell.nameLabel.text = data[indexPath.row].name
        cell.imageView?.image = UIImage(named: data[indexPath.row].pic)

        return cell
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
