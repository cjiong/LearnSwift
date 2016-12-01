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
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: 节数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //MARK: 一节里的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    //MARK: cell的设置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCell
        
        let currentPlayer = data[indexPath.row]
        
        cell.playerImage.image = UIImage(named: currentPlayer.image)
        cell.playerName.text = currentPlayer.name
        
        return cell
    }

    //MARK: 操作
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let like = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "喜欢") { action, index in
            print("You have tapped like button")
        
        }
        like.backgroundColor = UIColor.red
        
        let chat = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "聊聊") { action, index in
            print("You have tapped chat button")
        }
        chat.backgroundColor = UIColor.blue
        
        let share = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "分享") { (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let activityItem = self.data[indexPath.row]
            
            let activityViewController = UIActivityViewController(activityItems: [activityItem.image as String], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        share.backgroundColor = UIColor.brown
        
        return [share, chat, like]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

