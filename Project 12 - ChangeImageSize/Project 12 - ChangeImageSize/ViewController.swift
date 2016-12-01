//
//  ViewController.swift
//  Project 12 - ChangeImageSize
//
//  Created by 陈炯 on 16/5/25.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 多指触摸操作
        self.view.isMultipleTouchEnabled = true
        
        imageView = UIImageView(image: UIImage(named: "JH13"))
        
        setUpScrollView()
        scrollView.delegate = self
        
        setZoomScale(scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        recenterImage()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setZoomScale(scrollView.bounds.size)
        
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        
        recenterImage()
    }

    //MARK: 设置 scrollview 属性，并添加到 view 上
    fileprivate func setUpScrollView() {
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    //MARK: 设置缩放倍数
    fileprivate func setZoomScale(_ scrollViewSize: CGSize) {
        
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minimumScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minimumScale
        scrollView.maximumZoomScale = 2.5
    }
    
    fileprivate func recenterImage() {
        
        var horizonSpace = CGFloat()
        var verticalSpace = CGFloat()
        
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        
        if imageViewSize.width < scrollViewSize.width {
             horizonSpace = (scrollViewSize.width - imageViewSize.width) / 2.0
        } else {
             horizonSpace = 0.0
        }
        
        if imageViewSize.height < scrollViewSize.height {
             verticalSpace = (scrollViewSize.height - scrollViewSize.height) / 2.0
        } else {
             verticalSpace = 0.0
        }
        
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizonSpace, verticalSpace, horizonSpace)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.recenterImage()
    }
    
}

