//
//  PopoverMenuViewController.swift
//  Project 30 - PopoverMenu
//
//  Created by 陈炯 on 16/7/10.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class PopoverMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data: [MenuItem] = [
                             MenuItem(picture: "1", name: "发起群聊"),
                             MenuItem(picture: "2", name: "添加朋友"),
                             MenuItem(picture: "3", name: "扫一扫"),
                             MenuItem(picture: "4", name: "收付款")
                           ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PopoverMenuTableViewCell
        
        cell.menuImage.image = UIImage(named: data[indexPath.row].picture)
        cell.menuName.setTitle(data[indexPath.row].name, forState: UIControlState.Normal)
        
        return cell
    }
    
    
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
