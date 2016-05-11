//
//  BeginPageViewController.swift
//  Project 03 - LoginPageAnimation
//
//  Created by 陈炯 on 16/5/11.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class BeginPageViewController: UIViewController {
    
    //注册按钮和登陆按钮
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置按钮圆角半径
        signUpButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}