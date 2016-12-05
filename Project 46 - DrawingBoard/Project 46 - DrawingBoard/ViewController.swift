//
//  ViewController.swift
//  Project 46 - DrawingBoard
//
//  Created by 陈炯 on 16/7/26.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: DrawingBoard!
    
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.backgroundColor = UIColor.white
        saveImageButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
    }
    
    @IBAction func changeStrokeColor(_ sender: UIButton) {
        
        //BUG: 会使所有线条的颜色都改变
        board.pathColor = sender.backgroundColor!
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        let image = self.board.getImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let alertController = UIAlertController(title: "保存成功", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        self.board.clearBoard()
    }
    
    @IBAction func clearDrawBoard(_ sender: UIButton) {
        self.board.clearBoard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

