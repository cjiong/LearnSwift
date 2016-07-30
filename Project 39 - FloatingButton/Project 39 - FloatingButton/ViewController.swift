//
//  ViewController.swift
//  Project 39 - FloatingButton
//
//  Created by 陈炯 on 16/7/17.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wechatLabel: UILabel!
    @IBOutlet weak var wechatImageView: UIImageView!
    @IBOutlet weak var wechatView: UIView!
    
    @IBOutlet weak var qqLabel: UILabel!
    @IBOutlet weak var qqImageView: UIImageView!
    @IBOutlet weak var qqView: UIView!
    
    @IBOutlet weak var weiboLabel: UILabel!
    @IBOutlet weak var weiboImageView: UIImageView!
    @IBOutlet weak var weiboView: UIView!
    
    @IBOutlet weak var floatingButtonImageView: UIImageView!
    
    @IBOutlet weak var floatingButtonTopToWeiboViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var weiboViewTopToQQViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var qqViewTopToWeChatViewBottomConstraint: NSLayoutConstraint!
    
    var floatingButtonIsActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFloatingButton()
        
        //MARK: 创建并添加手势
        let gesture = UITapGestureRecognizer(target: self, action: "floatingButtonDidTouched:")
        floatingButtonImageView.addGestureRecognizer(gesture)
        
    }
    
    func initFloatingButton() {
        
        floatingButtonImageView.layer.cornerRadius = floatingButtonImageView.frame.width / 2
        wechatImageView.layer.cornerRadius = wechatImageView.frame.width / 2
        qqImageView.layer.cornerRadius = qqImageView.frame.width / 2
        weiboImageView.layer.cornerRadius = weiboImageView.frame.width / 2
        
        qqView.hidden = true
        weiboView.hidden = true
        wechatView.hidden = true
        
        qqLabel.alpha = 0
        weiboLabel.alpha = 0
        wechatLabel.alpha = 0
        
        qqViewTopToWeChatViewBottomConstraint.constant = 0
        weiboViewTopToQQViewBottomConstraint.constant = 0
        floatingButtonTopToWeiboViewBottomConstraint.constant = 0
        
    }
    
    func floatingButtonDidTouched(sender: UITapGestureRecognizer) {
        
        if !floatingButtonIsActive {
            
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                
                self.wechatView.hidden = false
                self.qqView.hidden = false
                self.weiboView.hidden = false

                self.wechatLabel.alpha = 1
                self.qqLabel.alpha = 1
                self.weiboLabel.alpha = 1
                self.floatingButtonImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
                self.floatingButtonTopToWeiboViewBottomConstraint.constant += 30
                self.weiboViewTopToQQViewBottomConstraint.constant += 30
                self.qqViewTopToWeChatViewBottomConstraint.constant += 30
                self.view.layoutIfNeeded()
                
                }, completion: { _ in
                    
                    self.floatingButtonIsActive = true
            })
            
            
        } else {
            
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                
                self.wechatView.center.y = self.qqView.center.y
                self.wechatLabel.alpha = 0
                self.view.layoutIfNeeded()
                
                }, completion: { _ in
                    
                    UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        
                        self.wechatView.center.y = self.weiboView.center.y
                        self.qqView.center.y = self.weiboView.center.y
                        self.qqLabel.alpha = 0
                        self.view.layoutIfNeeded()
                        
                        }, completion: { _ in
                            
                            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                                
                                self.wechatView.center.y = self.floatingButtonImageView.center.y
                                self.qqView.center.y = self.floatingButtonImageView.center.y
                                self.weiboView.center.y = self.floatingButtonImageView.center.y
                                self.weiboLabel.alpha = 0
                                self.view.layoutIfNeeded()
                                
                                }, completion: { _ in
                                    
                                    UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                                        
                                        self.floatingButtonImageView.transform = CGAffineTransformIdentity
                                        
                                        }, completion: { _ in
                                            
                                            self.floatingButtonTopToWeiboViewBottomConstraint.constant = 0
                                            self.weiboViewTopToQQViewBottomConstraint.constant = 0
                                            self.qqViewTopToWeChatViewBottomConstraint.constant = 0
                                            self.view.layoutIfNeeded()
                                            
                                            self.qqView.hidden = true
                                            self.weiboView.hidden = true
                                            self.wechatView.hidden = true
                                            
                                            self.floatingButtonIsActive = false
                                            
                                            
                                    })
                                    
                            })
                    })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}




