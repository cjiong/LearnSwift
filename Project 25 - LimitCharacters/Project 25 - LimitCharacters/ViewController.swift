//
//  ViewController.swift
//  Project 25 - LimitCharacters
//
//  Created by 陈炯 on 16/6/12.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationButton.layer.cornerRadius = 15
        
        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.borderWidth = 0.5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK:
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let textViewString = textView.text
        countLabel.text = "\(140 - textViewString.characters.count)"
        
        if range.length > 140 {
            return false
        }
        
        let newLength = textViewString.characters.count + range.length
        
        return newLength < 140
    }
    
    func keyBoardWillShow(note: NSNotification) {
        
        let userInfo = note.userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let durantion = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let Y = keyBoardBounds.size.height
        
        let animation: (() -> Void) = {
            self.bottomView.transform = CGAffineTransformMakeTranslation(0, -Y)
        }
        
        if durantion > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(durantion, delay: 0, options: options, animations: animation, completion: nil)
        } else {
            
            animation()
        }
        
    }
    
    func keyBoardWillHide(note: NSNotification) {
        
        let userInfo = note.userInfo
        let durantion = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        let animation: (() -> Void) = {
            self.bottomView.transform = CGAffineTransformIdentity
        }
        
        if durantion > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(durantion, delay: 0, options: options, animations: animation, completion: nil)
 
        } else {
            animation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }

    
}

