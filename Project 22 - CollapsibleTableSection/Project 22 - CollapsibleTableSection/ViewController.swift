//
//  ViewController.swift
//  Project 22 - CollapsibleTableSection
//
//  Created by 陈炯 on 16/6/7.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    struct Section {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        //MARK: 构造器
        init(name: String, items: [String]) {
            self.name = name
            self.items = items
            self.collapsed = false
        }
    }
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 数据
        sections = [
              Section(name: "Farrari", items: ["LaFerrari", "Enzo", "F40", "F50", "288GTO", "FXX K","FXX"]),
              Section(name: "Lamborghini", items: ["Aventador", "Reventon", "Huracan", "Gallardo", "Sesto Elemento", "Veneno", "Centenario", "Diablo"]),
              Section(name: "Aston Martin", items: ["One-77", "Vanquish", "Vulcan", "Vantage", "Rapide", "DBS", "DB11"]),
              Section(name: "Porsche", items: ["918 Spyder", "Cayenne", "Macan", "911 Turbo S", "Panamera", "Carrera GT"])
        ]
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (sections[section].collapsed == true) {
            return 0
        } else {
            return sections[section].items.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("header") as! CollapsibleHeader
        
        header.unfoldButton.tag = section
        header.brandLabel.text = sections[section].name
        header.unfoldButton.rotate(sections[section].collapsed! ? 0.0 : CGFloat(M_PI_2))
        
        return header.contentView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    //MARK: 添加点击事件
    @IBAction func unfoldButtonDidTouch(sender: AnyObject) {
        
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        //MARK: 点击后改变状态
        sections[section].collapsed = !collapsed
        
        //MARK: 重载Section数据
        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: 扩展
extension UIView {
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}


