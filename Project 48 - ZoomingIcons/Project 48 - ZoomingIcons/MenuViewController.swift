//
//  MenuViewController.swift
//  Project 48 - ZoomingIcons
//
//  Created by 陈炯 on 16/8/13.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MenuViewController: UICollectionViewController, ZoomingIconViewController {
    var selectedIndexPath: IndexPath?
    
    let data = [
        SocialItem(image: UIImage(named: "icon-twitter"), color: UIColor(red: 0.255, green: 0.557, blue: 0.910, alpha: 1), name: "Twitter", summary: "Twitter is an online social networking service that enables users to send and read short 140-character messages called \"tweets\"."),
        SocialItem(image: UIImage(named: "icon-facebook"), color: UIColor(red: 0.239, green: 0.353, blue: 0.588, alpha: 1), name: "Facebook", summary: "Facebook (formerly thefacebook) is an online social networking service headquartered in Menlo Park, California. Its name comes from a colloquialism for the directory given to students at some American universities."),
        SocialItem(image: UIImage(named: "icon-youtube"), color: UIColor(red: 0.729, green: 0.188, blue: 0.180, alpha: 1), name: "Youtube", summary: "YouTube is a video-sharing website headquartered in San Bruno, California. The service was created by three former PayPal employees in February 2005 and has been owned by Google since late 2006. The site allows users to upload, view, and share videos."),
        SocialItem(image: UIImage(named: "icon-vimeo"), color: UIColor(red: 0.329, green: 0.737, blue: 0.988, alpha: 1), name: "Vimeo", summary: "Vimeo is a U.S.-based video-sharing website on which users can upload, share and view videos. Vimeo was founded in November 2004 by Jake Lodwick and Zach Klein."),
        SocialItem(image: UIImage(named: "icon-instagram"), color: UIColor(red: 0.325, green: 0.498, blue: 0.635, alpha: 1), name: "Instagram", summary: "Instagram is an online mobile photo-sharing, video-sharing and social networking service that enables its users to take pictures and videos, and share them on a variety of social networking platforms, such as Facebook, Twitter, Tumblr and Flickr.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SocialItemCell
        
        var index = 0
        for s in 0..<indexPath.section {
            index += self.collectionView(collectionView, numberOfItemsInSection: s)
        }
        index += indexPath.item
        
        let item = data[index]
        cell.item = item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let numberOfCells = self.collectionView(collectionView, numberOfItemsInSection: section)
        let widthOfCells = CGFloat(numberOfCells) * layout.itemSize.width + CGFloat(numberOfCells-1) * layout.minimumInteritemSpacing
        
        let inset = (collectionView.bounds.width - widthOfCells) / 2.0
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 40, right: inset)
    }
    
    
    //MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        var index = 0
        for s in 0..<indexPath.section {
            index += self.collectionView(collectionView, numberOfItemsInSection: s)
        }
        index += indexPath.item
        
        let item = data[index]
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.item = item
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func zoomingIconColoredViewForTransition(_ transition: ZoomingIconTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView!.cellForItem(at: indexPath) as! SocialItemCell
            return cell.coloredView
        }
        else {
            return nil
        }
    }
    
    func zoomingIconImageViewForTransition(_ transition: ZoomingIconTransition) -> UIImageView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView!.cellForItem(at: indexPath) as! SocialItemCell
            return cell.imageView
        }
        else {
            return nil
        }
    }
}
