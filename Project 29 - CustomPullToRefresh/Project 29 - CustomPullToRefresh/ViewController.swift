//
//  ViewController.swift
//  Project 29 - CustomPullToRefresh
//
//  Created by 陈炯 on 16/7/1.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshController: UIRefreshControl!
    var customView: UIView!
    var labelsArray: [UILabel] = []
    var isAnimating = false
    var timer: NSTimer!
    
    var currentLabel = 0
    var currentColor = 0
    
    var data = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController = UIRefreshControl()
        refreshController.backgroundColor = UIColor.clearColor()
        refreshController.tintColor = UIColor.clearColor()
        tableView.addSubview(refreshController)
        
        loadCustomRefreshContents()

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel!.font = UIFont(name: "Avenir Next", size: 30)
        cell.textLabel!.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: Key
    func loadCustomRefreshContents() {
        
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents[0] as! UIView
        customView.frame = refreshController.bounds
        
        for var i = 0; i < customView.subviews.count; i++ {
            
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
            
        }
        
        refreshController.addSubview(customView)
    }
    
    func refreshAnimateStep1() {
        
        isAnimating = false
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.labelsArray[self.currentLabel].transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            self.labelsArray[self.currentLabel].textColor = self.getNextColor()
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    
                    self.labelsArray[self.currentLabel].transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                        
                        ++self.currentLabel
                        
                        if self.currentLabel < self.labelsArray.count {
                            
                            self.refreshAnimateStep1()
                            
                        } else {
                            
                            self.refreshAnimateStep2()
                            
                        }
                })
        }
    }
    
    func refreshAnimateStep2() {
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            for var i = 0; i < self.labelsArray.count; i++ {
                
                self.labelsArray[i].transform = CGAffineTransformMakeScale(1.1 + 0.1 * CGFloat(i), 1.1 + 0.1 * CGFloat(i))
                
            }
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    
                    for var j = 9; j >= 0; j-- {
                        
                        self.labelsArray[j].transform = CGAffineTransformIdentity
                        
                    }

                    
                    }, completion: { (finished) -> Void in
                        
                        if self.refreshController.refreshing {
                            
                            self.currentLabel = 0
                            self.refreshAnimateStep1()
                            
                        } else {
                            
                            self.isAnimating = false
                            self.currentLabel = 0
                            for var i = 0; i < self.labelsArray.count - 1; i++ {
                                
                                self.labelsArray[i].transform = CGAffineTransformIdentity
                                
                            }
                            
                        }
                })
  
        }
    }
    
    
    func getNextColor() -> UIColor {
        
        var colorArray: [UIColor] = [UIColor.brownColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.redColor(), UIColor.grayColor(), UIColor.grayColor()]
        
        if currentColor == colorArray.count {
            
            currentColor = 0
            
        }
        
        let returnColor = colorArray[currentColor]
        ++currentColor
        
        return returnColor
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshController.refreshing {
            if !isAnimating {
                
                timer = NSTimer.scheduledTimerWithTimeInterval(4.3, target: self, selector: "stopAnimation", userInfo: nil, repeats: true)

                refreshAnimateStep1()
                
            }
        }
    }
    
    func stopAnimation() {
        
        refreshController.endRefreshing()
        timer.invalidate()
        timer = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

