//
//  ViewController.swift
//  Project 21 - HeaderTableView
//
//  Created by 陈炯 on 16/6/6.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ferrari = ["LaFerrari", "Enzo", "F50", "F40", "F12 TDF"]
    var lamborghini = ["Aventador", "Huracan", "Veneno", "Murcielago", "Reventon"]
    var astonMartin = ["One-77", "Vulcan", "Vanquish", "Vantage", "DB11"]
    var porsche = ["918 Spyder", "911 GT3", "Carrera GT", "Panamera", "Cayenne"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        switch ((indexPath as NSIndexPath).section) {
        case 0: cell.textLabel?.text = ferrari[(indexPath as NSIndexPath).row]
        case 1: cell.textLabel?.text = lamborghini[(indexPath as NSIndexPath).row]
        case 2: cell.textLabel?.text = astonMartin[(indexPath as NSIndexPath).row]
        case 3: cell.textLabel?.text = porsche[(indexPath as NSIndexPath).row]
        default: cell.textLabel?.text = ""
        }
        return cell
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell1 = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        headerCell1.backgroundColor = UIColor.gray
        
        switch (section) {
        case 0: headerCell1.headerLabel.text = " Ferrari"
        case 1: headerCell1.headerLabel.text = " Lamborghini"
        case 2: headerCell1.headerLabel.text = " Aston Martin"
        case 3: headerCell1.headerLabel.text = " Porsche"
        default: headerCell1.headerLabel.text = ""
        }
        return headerCell1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
}










