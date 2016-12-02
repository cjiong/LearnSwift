//
//  SetDateController.swift
//  Project 19 - SetDateAndTime
//
//  Created by 陈炯 on 16/6/5.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class SetDateController: UIViewController {
    
    var formatter = DateFormatter()
    
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
        
        let data = Date()
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm"
        currentTimeLabel.text = timeFormatter.string(from: data) as String
    }
    
    @IBAction func backButtonDidTouch(_ sender: AnyObject) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTouch(_ sender: AnyObject) {
        
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: datePicker.date)
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let timeString = formatter.string(from: timePicker.date)
        
        let resultString = dateString + " " + timeString
        
        self.newDate!(resultString)
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
}
