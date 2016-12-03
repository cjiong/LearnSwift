//
//  ViewController.swift
//  Project 38 - SavePhotoToCustomUlbum
//
//  Created by 陈炯 on 16/7/15.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 10
    }
    
    @IBAction func savePhoto(_ sender: AnyObject) {
        
        let image = photoImageView?.image
        
        CustomUlbum.sharedInstance.saveImage(image: image!, ulbumName: "James Harden")
        
        let alertController = UIAlertController(title: "saved successful", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

