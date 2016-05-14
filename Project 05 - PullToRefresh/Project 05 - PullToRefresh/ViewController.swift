//
//  ViewController.swift
//  Project 05 - PullToRefresh
//
//  Created by 陈炯 on 16/5/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentifer = "NewCellIdentifer"
    
    let originEmoji = ["😏😏😏", "😂😂😂", "😘😘😘"]
    let newEmoji = ["🌚🌚🌚", "😱😱😱", "😳😳😳", "😄😄😄"]
    var emojiData = [String]()
    var tableViewController = UITableViewController(style: .Plain)
    
    var refreshControl = UIRefreshControl()
    var navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiData = originEmoji
        let emojiTableView = tableViewController.tableView
        
        emojiTableView.backgroundColor = UIColor.grayColor()
        emojiTableView.delegate = self
        emojiTableView.dataSource = self
        
        emojiTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: "didRoadEmoji", forControlEvents: .ValueChanged)
        
        self.refreshControl.backgroundColor = UIColor.brownColor()
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.refreshControl.attributedTitle = NSAttributedString(string: "最近一次加载\(NSDate())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.blueColor()
        
        self.title = "emoji"
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        
        emojiTableView.rowHeight = UITableViewAutomaticDimension
        emojiTableView.estimatedRowHeight = 60.0
        emojiTableView.tableFooterView = UIView(frame: CGRectZero)
        emojiTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(emojiTableView)
        self.view.addSubview(navigationBar)
        
    }

    
    //数据源协议
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer)! as UITableViewCell
        
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        cell.textLabel?.font = UIFont(name: "systemFont", size: 50)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
    func didRoadEmoji() {
        self.emojiData = newEmoji
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

