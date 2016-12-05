//
//  ViewController.swift
//  Project 47 - TagViewApp
//
//  Created by 陈炯 on 16/7/27.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?

    var controllerArray : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller1: UIViewController = UIViewController()
        controller1.title = "要闻"
        controllerArray.append(controller1)
        
        let controller2: UIViewController = UIViewController()
        controller2.title = "奥运"
        controllerArray.append(controller2)
        
        let controller3: UIViewController = UIViewController()
        controller3.title = "视频"
        controllerArray.append(controller3)
        
        let controller4: UIViewController = UIViewController()
        controller4.title = "财经"
        controllerArray.append(controller4)
        
        let controller5: UIViewController = UIViewController()
        controller5.title = "娱乐"
        controllerArray.append(controller5)
        
        let controller6: UIViewController = UIViewController()
        controller6.title = "社会"
        controllerArray.append(controller6)
        
        let controller7: UIViewController = UIViewController()
        controller7.title = "军事"
        controllerArray.append(controller7)
        
        let controller8: UIViewController = UIViewController()
        controller8.title = "汽车"
        controllerArray.append(controller8)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .useMenuLikeSegmentedControl(true),
            .scrollMenuBackgroundColor(UIColor(red: 0.42, green: 0.80, blue: 1, alpha: 1)),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.white)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview((pageMenu?.view)!)

    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

