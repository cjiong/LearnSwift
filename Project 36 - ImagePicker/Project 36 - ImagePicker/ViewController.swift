//
//  ViewController.swift
//  Project 36 - ImagePicker
//
//  Created by 陈炯 on 16/7/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var headPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headPicture.layer.masksToBounds = true
        
        //MARK: 给imageView添加点击事件
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: Selector("changeHeadPicture"))
        headPicture.addGestureRecognizer(gestureRecognizer)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func changeHeadPicture() {
        
        let userIconAlert = UIAlertController(title: "请选择", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let chooseFromPhotoalbum = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default, handler: chooseFromPhotoAlbum)
        userIconAlert.addAction(chooseFromPhotoalbum)
        
        let chooseFromcamera = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default,handler: chooseFromCamera)
        userIconAlert.addAction(chooseFromcamera)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        userIconAlert.addAction(cancelAction)
        
        self.presentViewController(userIconAlert, animated: true, completion: nil)
    
        
    }
    
    func chooseFromPhotoAlbum(alertAction: UIAlertAction) -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            let picker = UIImagePickerController()
            
            //MARK: 设置代理
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.allowsEditing = true
            
            self.presentViewController(picker, animated: true, completion: nil)
            
        } else {
            
            print("error")
        }
        
    }

    func chooseFromCamera(alertAction: UIAlertAction) -> Void {
     
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let picker = UIImagePickerController()
            
            //MARK: 设置代理
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing = true
            
            self.presentViewController(picker, animated: true, completion: nil)
            
        } else {
            
            print("error")
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let rect = CGRect(x: 292, y: 268, width: 77, height: 75)
        headPicture.frame = rect
        headPicture.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

