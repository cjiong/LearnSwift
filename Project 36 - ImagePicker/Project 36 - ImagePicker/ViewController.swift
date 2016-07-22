//
//  ViewController.swift
//  Project 36 - ImagePicker
//
//  Created by 陈炯 on 16/7/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var headPicture: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func changeHeadPicture(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            let picker = UIImagePickerController()
            
            //MARK: 设置代理
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.allowsEditing = true
            
            self.presentViewController(picker, animated: true, completion: { () -> Void in
                
            })
            
        } else {
            
            print("error")
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        headPicture.setBackgroundImage(image, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

