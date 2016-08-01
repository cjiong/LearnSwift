//
//  ViewController.swift
//  Project 42 - ImagePlayView
//
//  Created by 陈炯 on 16/7/20.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var bannerView: UICollectionView!
    
    var cvData = ["pic1", "pic2", "pic3", "pic4", "pic5"]
    
    var tvData = [
        Car(country: "Germany", brand: "Mercedes Benz"), Car(country: "Germany", brand: "BMW"),
        Car(country: "Germany", brand: "Audi"), Car(country: "Germany", brand: "Volkswagen"),
        Car(country: "American", brand: "Ford"), Car(country: "American", brand: "Chevrolet"),
        Car(country: "American", brand: "Hummer"), Car(country: "American", brand: "Lincoln"),
        Car(country: "England", brand: "Range Rover"), Car(country: "England", brand: "Bently"),
        Car(country: "England", brand: "Aston Martin"), Car(country: "England", brand: "Jaguar"),
        Car(country: "Italy", brand: "Lamborghini"), Car(country: "Italy", brand: "Ferrari"),
        Car(country: "Italy", brand: "Maserati"), Car(country: "Italy", brand: "Alfa Romeo")
        
    ]
    
    var timer: NSTimer!
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    func startTimer() {
        
        self.timer = NSTimer.init(timeInterval: 2.0, target: self, selector: "automaticScroll", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
    }
    
    func automaticScroll() {
        
        self.index += 1
        if self.index > cvData.count - 1 {
            
            self.index = 0
            self.bannerView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: self.index, inSection: 0), atScrollPosition: .Left, animated: false)
            
        } else {
            
            self.bannerView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: self.index, inSection: 0), atScrollPosition: .Left, animated: true)
        }
    }

    //MARK: tableview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as! CarTableViewCell
        
        cell.countryLabel.text = tvData[indexPath.row].country
        cell.brandLabel.text = tvData[indexPath.row].brand
        
        return cell
    }
    
    //MARK: collectionview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cvData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CarCollectionViewCell
        
        cell.carImageView.image = UIImage(named: cvData[indexPath.row])
        
        return cell
    }
    
    //MARK: scrollview
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        if scrollView.isKindOfClass(UICollectionView.self) {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.isKindOfClass(UICollectionView.self) {
            
            self.index = Int(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width)
            self.startTimer()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

