//
//  ViewController.swift
//  Project 03 - LoginPageAnimation
//
//  Created by 陈炯 on 16/5/10.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func backButtonDidToch(sender: AnyObject) {
       self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //用户名和密码输入框
    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    //水平居中约束
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置输入框和按钮圆角半径
        usernameTextFiled.layer.cornerRadius = 5
        passwordTextFiled.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlignUsername.constant -= view.layer.bounds.width
        centerAlignPassword.constant -= view.layer.bounds.width
        loginButton.alpha = 0
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.00, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.10, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.20, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.loginButton.alpha = 1
            
            }, completion: nil)
        
    }
    
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        
        let bounds = self.loginButton.bounds
        
        //点击按钮出现的动画 按钮变宽
        UIView.animateWithDuration(1.0, delay: 0.00, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 80, height: bounds.size.height)
            self.loginButton.enabled = true
            }, completion: { finished in self.loginButton.enabled = true
                
        })
    }
}












