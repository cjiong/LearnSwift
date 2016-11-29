//
//  ViewController.swift
//  Project 08 - WebBrowser
//
//  Created by 陈炯 on 16/5/20.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var webView1: UIWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置代理
        textField1.delegate = self
        webView1.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //加载请求
        loadUrl(textField.text!, web: webView1)
        //解除textField的第一响应者的注册资格，键盘消失；
        //若没有这一步，键盘会一直留在屏幕内
        textField.resignFirstResponder()
        return true
    }
    
    //加载请求的方法
    func loadUrl(_ url: String, web: UIWebView) {
        
        //载入输入的请求
        let aUrl = URL(string: ("https://" + url))
        let urlRequest = URLRequest(url: aUrl!)
        web.loadRequest(urlRequest)
        
    }
    
    //网页开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        //轮圈开始转动
        loading.startAnimating()
        
        //状态栏的网络请求轮圈开始转动
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    //网页加载结束
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        loading.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

