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
        
        self.tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
        
        return cell
    }
    
    //MARK: 实现索引数据源代理方法
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return headers
    }
    
    //MARK: 表头
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: 点击索引方法
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
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

