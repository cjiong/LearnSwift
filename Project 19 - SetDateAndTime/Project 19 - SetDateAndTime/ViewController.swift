//
//  ViewController.swift
//  Project 19 - SetDateAndTime
//
//  Created by 陈炯 on 16/6/5.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    var date = ""
    
    override func viewWillAppear(animated: Bool) {
        
        print(date)
        dateLabel.text = date

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationVC = segue.destinationViewController as! UINavigationController
        let setDateVC = navigationVC.viewControllers.first as! SetDateController
        
        //MARK: 传值
        setDateVC.newDate = ({ string in self.date = string })
        
    }
    
}

