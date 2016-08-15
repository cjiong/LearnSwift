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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.backgroundColor = UIColor.whiteColor()
    }

    @IBAction func changeStrokeColor(sender: UIButton) {
        
        //BUG: 会使所有线条的颜色都改变
        board.pathColor = sender.backgroundColor!
    }
    
    @IBAction func saveImage(sender: UIButton) {
        
        let image = self.board.getImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBAction func clearDrawBoard(sender: UIButton) {
        board.clearBoard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

