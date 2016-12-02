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
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(date)
        dateLabel.text = date

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationVC = segue.destination as! UINavigationController
        let setDateVC = navigationVC.viewControllers.first as! SetDateController
        
        //MARK: 传值
        setDateVC.newDate = ({ string in self.date = string })
        
    }
    
}

