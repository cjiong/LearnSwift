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
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        
        generateButton.layer.cornerRadius = 5
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func generateButtonDidTouch(_ sender: AnyObject) {
        
        qrcodeImageView.image = createQRCodeFromString(textField.text, qrImageName: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createQRCodeFromString(_ qrString: String?, qrImageName: String?) -> UIImage? {
        
        if let QRString = qrString {
            
            let QRStringData = QRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            let QRFilter = CIFilter(name: "CIQRCodeGenerator")!
            QRFilter.setValue(QRStringData, forKey: "inputMessage")
            QRFilter.setValue("H", forKey: "inputCorrectionLevel")
            
            let QRCIImage = QRFilter.outputImage
            
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(QRCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            let transformImage = colorFilter.outputImage!.applying(transform)
            let codeImage = UIImage(ciImage: transformImage)

            
            //let codeImage = UIImage(CIImage: (colorFilter?.outputImage!.imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))!)
            
            if let iconImage = UIImage(named: qrImageName!) {
                
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: rect.size.width * 0.25, height: rect.size.height * 0.25)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            
            return codeImage
        }
        return nil
    }

    
}

