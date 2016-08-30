//
//  ViewController.swift
//  Project 52 - MusicIndicator
//
//  Created by 陈炯 on 16/8/30.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var data = [
        Song(name: "Immortals", artist: "Fall Out Boy"),
        Song(name: "What Make You Beautiful", artist: "One Direction"),
        Song(name: "Counting Stars", artist: "Coldplay"),
        Song(name: "Sugar", artist: "Maroon 5"),
        Song(name: "Apologize", artist: "OneRepublic"),
        Song(name: "Hall of Fame", artist: "The Script"),
        Song(name: "Numb", artist: "Linkin Park"),
        Song(name: "Let Her Go", artist: "Passenger"),
        Song(name: "Demons", artist: "Imagine Dragons"),
        Song(name: "Some Nights", artist: "Fun."),
        Song(name: "21 Guns", artist: "Green Day"),
        Song(name: "Mirrors", artist: "Justin Timberlake"),
        Song(name: "Here With You", artist: "Asher Book"),
        Song(name: "Freedom", artist: "Akon"),
        Song(name: "Here I Am", artist: "Bryan Adams"),
        Song(name: "Fool's Day", artist: "Blur")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! SongCell
        
        cell.namaeLabel.text = data[indexPath.row].name
        cell.artistLabel.text = data[indexPath.row].artist
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70.0
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        startMusicIndicatorAnimation(view, xPosition: 355.0, yPosition: 50.0)
        return view
    }
    
    func startMusicIndicatorAnimation(indicatorView: UIView, xPosition: CGFloat, yPosition: CGFloat) {
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 30.0)
        replicatorLayer.position = CGPoint(x: xPosition, y: yPosition)
        replicatorLayer.backgroundColor = UIColor.clearColor().CGColor
        indicatorView.layer.addSublayer(replicatorLayer)
        
        let bar = CALayer()
        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 3.0, height: 20.0)
        bar.position = CGPoint(x: 0.0, y: 5.0)
        bar.cornerRadius = 1.0
        bar.backgroundColor = UIColor.whiteColor().CGColor
        
        replicatorLayer.addSublayer(bar)
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y + 10.0
        move.duration = 0.5
        move.autoreverses = true
        move.repeatCount = Float.infinity
        
        bar.addAnimation(move, forKey: nil)
        
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(5.0, 0.0, 0.0)
        replicatorLayer.instanceDelay = 0.33

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

