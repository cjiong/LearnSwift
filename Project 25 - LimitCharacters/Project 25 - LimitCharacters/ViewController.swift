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
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.5
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK:
    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let textViewString = textView.text
        countLabel.text = "\(140 - (textViewString?.characters.count)!)"
        
        if range.length > 140 {
            return false
        }
        
        let newLength = (textViewString?.characters.count)! + range.length
        
        return newLength < 140
    }
    
    func keyBoardWillShow(_ note: Notification) {
        
        let userInfo = note.userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let durantion = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let Y = keyBoardBounds.size.height
        
        let animation: (() -> Void) = {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: -Y)
        }
        
        if durantion > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: durantion, delay: 0, options: options, animations: animation, completion: nil)
        } else {
            
            animation()
        }
        
    }
    
    func keyBoardWillHide(_ note: Notification) {
        
        let userInfo = note.userInfo
        let durantion = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        let animation: (() -> Void) = {
            self.bottomView.transform = CGAffineTransform.identity
        }
        
        if durantion > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: durantion, delay: 0, options: options, animations: animation, completion: nil)
 
        } else {
            animation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
}

