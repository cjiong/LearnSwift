//
//  ViewController.swift
//  Project 02 - CustomFonts
//
//  Created by 陈炯 on 16/5/3.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var data = ["生活不止眼前的苟且", "还有明天的苟且", "后天的苟且", "和那读不懂的诗", "还有那到不了的远方"]
    
    let fontNames = ["MFJinHei_Noncommercial-Regular", "MFTongXin_Noncommercial-Regular", "MFTongXin_Noncommercial-Regular1"]
    
    var fontRowIndex = 0

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var fontTableView: UITableView!
    @IBOutlet weak var changeFontButton: UIButton!
    @IBAction func changeFont(sender: AnyObject) {
        
        fontRowIndex = (fontRowIndex + 1) % 3
        fontTableView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置代理和数据源为self
        fontTableView.delegate = self
        fontTableView.dataSource = self
        
        //改变字体
        for family in UIFont.familyNames() {
            for font in UIFont.fontNamesForFamilyName(family) {
                print(font)
            }
        }
        
        //改变按钮样式
        changeFontButton.layer.cornerRadius = 55
        
    }
    
    //返回行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    //
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //设置单元格样式
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = fontTableView.dequeueReusableCellWithIdentifier("FontCell", forIndexPath: indexPath)
        let text = data[indexPath.row]
        
            cell.textLabel?.text = text
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size: 36)
        
        return cell
    }

    //实现数据源协议
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

}

