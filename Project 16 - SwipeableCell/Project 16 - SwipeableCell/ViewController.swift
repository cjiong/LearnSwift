//
//  ViewController.swift
//  Project 16 - SwipeableCell
//
//  Created by 陈炯 on 16/5/30.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let data = [
        player(image: "1", name: " Tracy McGrady"),
        player(image: "2", name: " Kobe Bryant"),
        player(image: "3", name: " Michael Jordan"),
        player(image: "4", name: " Lebron James"),
        player(image: "5", name: " Dwight Howard"),
        player(image: "6", name: " Jeremy Lin"),
        player(image: "7", name: " Kevin Durant"),
        player(image: "8", name: " Steven Curry")
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: 节数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    //MARK: 一节里的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    //MARK: cell的设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell") as! PlayerCell
        
        let currentPlayer = data[indexPath.row]
        
        cell.playerImage.image = UIImage(named: currentPlayer.image)
        cell.playerName.text = currentPlayer.name
        
        return cell
    }

    //MARK: 操作
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let like = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "喜欢") { action, index in
            print("You have tapped like button")
        
        }
        like.backgroundColor = UIColor.redColor()
        
        let chat = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "聊聊") { action, index in
            print("You have tapped chat button")
        }
        chat.backgroundColor = UIColor.blueColor()
        
        let share = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "分享") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            
            let activityItem = self.data[indexPath.row]
            
            let activityViewController = UIActivityViewController(activityItems: [activityItem.image as String], applicationActivities: nil)
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
            
        }
        share.backgroundColor = UIColor.brownColor()
        
        return [share, chat, like]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

