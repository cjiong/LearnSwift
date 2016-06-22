//
//  ViewController.swift
//  Project 27 - TableViewIndex
//
//  Created by 陈炯 on 16/6/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView?
    
    var headers = ["A", "B", "C", "D", "E"]
    
    var data = [ ["Amy", "Alice", "Antony", "Alexander", "Aaron"],
                 ["Bryant", "Black", "Block", "Barry", "Barton"],
                 ["Carter", "Cash", "Calvin", "Charles", "Christian"],
                 ["David", "Dominic", "Dwight", "Devin", "Derrick"],
                 ["Edison", "Edward", "Elton", "Elvis", "Eric"]
               ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Grouped)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
        
        return cell
    }
    
    //MARK: 实现索引数据源代理方法
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return headers
    }
    
    //MARK: 表头
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: 点击索引方法
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        var currentIndex = 0
        //MARK: 遍历索引值
        for character in headers {
            
            //MARK: 判断索引值和组名称是否相等，返回组坐标
            if character == title {
                return currentIndex
            }
            
            currentIndex += 1
        }
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

