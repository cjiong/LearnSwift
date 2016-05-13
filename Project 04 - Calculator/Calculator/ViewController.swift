//
//  ViewController.swift
//  Calculator
//
//  Created by 陈炯 on 15/9/15.
//  Copyright (c) 2015年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    var logic : CalculatorLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainLabel.text = "0"
        logic = CalculatorLogic()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        logic = nil
        
    }

    @IBAction func operandPressed(sender: AnyObject) {
        
        let btn : UIButton = sender as! UIButton
        mainLabel.text = logic.calculatorByTag(btn.tag, withMainLabelString: mainLabel.text!)
    }
    
    @IBAction func equalsPressed(sender: AnyObject) {
        
        let btn : UIButton = sender as! UIButton
        mainLabel.text = logic.calculatorByTag(btn.tag, withMainLabelString: mainLabel.text!)
    }
    
    
    @IBAction func clearPressed(sender: AnyObject) {
        
        mainLabel.text = "0"
        logic.clean()
    }
    
    @IBAction func decimalPressed(sender: AnyObject) {
        
        if logic.doesStringContainDecimal(mainLabel.text!) == false {
            let string = mainLabel.text! + "."
            mainLabel.text = string
        }
    }
    
    @IBAction func numberButtonPressed(sender: AnyObject) {
        
        let btn : UIButton = sender as! UIButton
        mainLabel.text = logic.updateMainLabelStringByNumberTag(btn.tag, withMainLabelString: mainLabel.text!)
    }


    
    
    
    
    
    
    
    
    
    
    
    

}

