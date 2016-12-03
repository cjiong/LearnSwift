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
    var timer: Timer!
    
    var currentLabel = 0
    var currentColor = 0
    
    var data = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController = UIRefreshControl()
        refreshController.backgroundColor = UIColor.clear
        refreshController.tintColor = UIColor.clear
        tableView.addSubview(refreshController)
        
        loadCustomRefreshContents()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell!
        
        cell?.textLabel!.font = UIFont(name: "Avenir Next", size: 30)
        cell?.textLabel!.text = data[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: Key
    func loadCustomRefreshContents() {
        
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents?[0] as! UIView
        customView.frame = refreshController.bounds
        
        for i in 0 ..< customView.subviews.count {
            
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
            
        }
        
        refreshController.addSubview(customView)
    }
    
    func refreshAnimateStep1() {
        
        isAnimating = false
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            
            self.labelsArray[self.currentLabel].transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            self.labelsArray[self.currentLabel].textColor = self.getNextColor()
            
            }) { (finished) -> Void in
                
                UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                    
                    self.labelsArray[self.currentLabel].transform = CGAffineTransform.identity
                    
                    }, completion: { (finished) -> Void in
                        
                        self.currentLabel += 1
                        
                        if self.currentLabel < self.labelsArray.count {
                            
                            self.refreshAnimateStep1()
                            
                        } else {
                            
                            self.refreshAnimateStep2()
                            
                        }
                })
        }
    }
    
    func refreshAnimateStep2() {
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            
            for i in 0 ..< self.labelsArray.count {
                
                self.labelsArray[i].transform = CGAffineTransform(scaleX: 1.1 + 0.1 * CGFloat(i), y: 1.1 + 0.1 * CGFloat(i))
                
            }
            
            }) { (finished) -> Void in
                
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                    
                    for j in 0 ..< 9 {
                        
                        self.labelsArray[9 - j].transform = CGAffineTransform.identity
                    
                    }

                    
                    }, completion: { (finished) -> Void in
                        
                        if self.refreshController.isRefreshing {
                            
                            self.currentLabel = 0
                            self.refreshAnimateStep1()
                            
                        } else {
                            
                            self.isAnimating = false
                            self.currentLabel = 0
                            for i in 0 ..< self.labelsArray.count - 1 {
                                
                                self.labelsArray[i].transform = CGAffineTransform.identity
                                
                            }
                            
                        }
                })
  
        }
    }
    
    
    func getNextColor() -> UIColor {
        
        var colorArray: [UIColor] = [UIColor.brown, UIColor.blue, UIColor.purple, UIColor.red, UIColor.gray, UIColor.gray]
        
        if currentColor == colorArray.count {
            
            currentColor = 0
            
        }
        
        let returnColor = colorArray[currentColor]
        currentColor += 1
        
        return returnColor
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshController.isRefreshing {
            if !isAnimating {
                
                timer = Timer.scheduledTimer(timeInterval: 4.3, target: self, selector: #selector(ViewController.stopAnimation), userInfo: nil, repeats: true)

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

