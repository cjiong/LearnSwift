//
//  ViewController.swift
//  Project 07 - DidiTaxi
//
//  Created by 陈炯 on 16/5/19.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DIOpenSDKDelegate {
    
    //实现DIOpenSDKDelegate协议
    func pageClose() {
        tipLabel.text = "哈哈，用不了是吧，这是要申请授权才能用的😏"
    }

    @IBOutlet weak var tipLabel: UILabel!
    @IBAction func startBtnDidTouch(_ sender: UIButton) {
        
        //注册账户和密码
        DIOpenSDK.registerApp("test", secret: "test")
        
        let option = DIOpenSDKRegisterOptions()
        
        DIOpenSDK.showDDPage(self, animated: true, params: option, delegate: self)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

