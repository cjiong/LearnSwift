//
//  ViewController.swift
//  Project 28 - GenerateQRCode
//
//  Created by 陈炯 on 16/6/22.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 代理
        textField.returnKeyType = UIReturnKeyType.Done
        textField.delegate = self
        
        generateButton.layer.cornerRadius = 5
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func generateButtonDidTouch(sender: AnyObject) {
        
        qrcodeImageView.image = createQRCodeFromString(textField.text, qrImageName: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createQRCodeFromString(qrString: String?, qrImageName: String?) -> UIImage? {
        
        if let QRString = qrString {
            
            let QRStringData = QRString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            let QRFilter = CIFilter(name: "CIQRCodeGenerator")!
            QRFilter.setValue(QRStringData, forKey: "inputMessage")
            QRFilter.setValue("H", forKey: "inputCorrectionLevel")
            
            let QRCIImage = QRFilter.outputImage
            
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(QRCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            
            let transform = CGAffineTransformMakeScale(5, 5)
            let transformImage = colorFilter.outputImage!.imageByApplyingTransform(transform)
            let codeImage = UIImage(CIImage: transformImage)

            
            //let codeImage = UIImage(CIImage: (colorFilter?.outputImage!.imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))!)
            
            if let iconImage = UIImage(named: qrImageName!) {
                
                let rect = CGRectMake(0, 0, codeImage.size.width, codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                
                codeImage.drawInRect(rect)
                let avatarSize = CGSizeMake(rect.size.width * 0.25, rect.size.height * 0.25)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.drawInRect(CGRectMake(x, y, avatarSize.width, avatarSize.height))
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            
            return codeImage
        }
        return nil
    }

    
}

