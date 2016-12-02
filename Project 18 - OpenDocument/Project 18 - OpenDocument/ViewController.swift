//
//  ViewController.swift
//  Project 18 - OpenDocument
//
//  Created by 陈炯 on 16/6/4.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: 文档可以为很多格式，比如PDF，PPT，WORD 等等，只需修改参数即可，这里用WORD文档举例
        let url = Bundle.main.url(forResource: "Travel", withExtension: "docx")
        
        if let url = url {
            
            let webview = UIWebView(frame: self.view.bounds)
            let urlRequest = URLRequest(url: url)
            webview.loadRequest(urlRequest)
            
            self.view.addSubview(webview)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

