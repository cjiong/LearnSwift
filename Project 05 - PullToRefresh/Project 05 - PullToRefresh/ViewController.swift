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
    
    let originEmoji = ["😏😏😏", "😂😂😂", "😘😘😘", "👀👀👀", "👊🏻👊🏻👊🏻", "👍🏼👍🏼👍🏼", "🐔🐔🐔"]
    let newEmoji = ["🌚🌚🌚", "😱😱😱", "😳😳😳", "😄😄😄", "😂😂😂", "😘😘😘", "👀👀👀", "🙊🙊🙊", "🐶🐶🐶"]
    var emojiData = [String]()
    var tableViewController = UITableViewController(style: .plain)
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiData = originEmoji
        let emojiTableView = tableViewController.tableView
        
        emojiTableView?.backgroundColor = UIColor.gray
        emojiTableView?.delegate = self
        emojiTableView?.dataSource = self
        
        emojiTableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(ViewController.didRoadEmoji), for: .valueChanged)
        
        self.refreshControl.backgroundColor = UIColor.black
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "最近一次加载\(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.blue
        
        emojiTableView?.rowHeight = UITableViewAutomaticDimension
        emojiTableView?.estimatedRowHeight = 80.0
        emojiTableView?.tableFooterView = UIView(frame: CGRect.zero)
        emojiTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.view.addSubview(emojiTableView!)
        //self.view.addSubview(navigationBar)
        
    }

    
    //数据源协议
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        
        cell.textLabel!.text = self.emojiData[(indexPath as NSIndexPath).row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel?.font = UIFont(name: "systemFont", size: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    func didRoadEmoji() {
        self.emojiData = newEmoji + originEmoji
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

