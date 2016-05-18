//
//  ViewController.swift
//  Project 06 - EmojiMachine
//
//  Created by 陈炯 on 16/5/17.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var bounds: CGRect = CGRectZero

    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBAction func goButtonDidTouch(sender: AnyObject) {
        
        //随机
        emojiPickerView.selectRow(Int(arc4random()) % 9 + 3, inComponent: 0, animated: true)
        emojiPickerView.selectRow(Int(arc4random()) % 9 + 3, inComponent: 1, animated: true)
        emojiPickerView.selectRow(Int(arc4random()) % 9 + 3, inComponent: 2, animated: true)
        
        //判断三个轮盘结果是否相同
        if(dataArray1[emojiPickerView.selectedRowInComponent(0)] == dataArray2[emojiPickerView.selectedRowInComponent(1)] && dataArray2[emojiPickerView.selectedRowInComponent(1)] == dataArray3[emojiPickerView.selectedRowInComponent(2)] && dataArray1[emojiPickerView.selectedRowInComponent(0)] == dataArray2[emojiPickerView.selectedRowInComponent(2)]) {
            
            resultLabel.text = "SUCCESS"
        } else {
            resultLabel.text = "Try Again"
        }

        //点击按钮动画
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .CurveLinear, animations: {
            
            self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width + 20, height: self.bounds.size.height)
            
            }, completion: { (complete: Bool) in
                
                UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    
                    self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    }, completion: nil)
                
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //key
        bounds = goButton.bounds
        imageArray = ["🐶", "🐼", "🐵", "🐸", "🐮", "🐲", "🐯", "🐰", "🐹", "🐭"]
        
        for(var i = 0; i < 100; i++) {
            dataArray1.append((Int)(arc4random() % 10))
            dataArray2.append((Int)(arc4random() % 10))
            dataArray3.append((Int)(arc4random() % 10))
        }
        
        resultLabel.text = ""
        
        //设置emojiPickerView数据源和代理
        emojiPickerView.dataSource = self
        emojiPickerView.delegate = self
        
        //goButton圆角半径
        goButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(animated: Bool) {
        
        goButton.alpha = 0.0
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.goButton.alpha = 1.0
            
            }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //转盘的数据行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    //转盘个数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //宽度和高度
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }

    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    //Key
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if (component == 0) {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if (component == 1) {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        //emoji大小和对齐方式
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = .Center
        
        return pickerLabel
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

