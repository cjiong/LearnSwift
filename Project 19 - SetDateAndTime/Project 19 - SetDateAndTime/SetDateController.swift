//
//  SetDateController.swift
//  Project 19 - SetDateAndTime
//
//  Created by 陈炯 on 16/6/5.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class SetDateController: UIViewController {
    
    var formatter = NSDateFormatter()
    
    //MARK: 传值函数
    var newDate: ((String) -> Void)?
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTime()
    }
    
    //MARK: 获取当前时间
    func showTime() {
        
        let data = NSDate()
        let timeFormatter = NSDateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm"
        currentTimeLabel.text = timeFormatter.stringFromDate(data) as String
    }
    
    @IBAction func backButtonDidTouch(sender: AnyObject) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonDidTouch(sender: AnyObject) {
        
        formatter.dateStyle = .MediumStyle
        let dateString = formatter.stringFromDate(datePicker.date)
        
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .NoStyle
        let timeString = formatter.stringFromDate(timePicker.date)
        
        let resultString = dateString + " " + timeString
        
        self.newDate!(resultString)
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
