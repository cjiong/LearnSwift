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
        gestureRecognizer.addTarget(self, action: #selector(ViewController.changeHeadPicture))
        headPicture.addGestureRecognizer(gestureRecognizer)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func changeHeadPicture() {
        
        let userIconAlert = UIAlertController(title: "请选择", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let chooseFromPhotoalbum = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.default, handler: chooseFromPhotoAlbum)
        userIconAlert.addAction(chooseFromPhotoalbum)
        
        let chooseFromcamera = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default,handler: chooseFromCamera)
        userIconAlert.addAction(chooseFromcamera)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        userIconAlert.addAction(cancelAction)
        
        self.present(userIconAlert, animated: true, completion: nil)
    
        
    }
    
    func chooseFromPhotoAlbum(_ alertAction: UIAlertAction) -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            
            //MARK: 设置代理
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
            
        } else {
            
            print("error")
        }
        
    }

    func chooseFromCamera(_ alertAction: UIAlertAction) -> Void {
     
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let picker = UIImagePickerController()
            
            //MARK: 设置代理
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
            
        } else {
            
            print("error")
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let rect = CGRect(x: 292, y: 268, width: 77, height: 75)
        headPicture.frame = rect
        headPicture.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

