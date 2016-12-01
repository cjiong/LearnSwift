//
//  ViewController.swift
//  Project 13 - MyLocation
//
//  Created by 陈炯 on 16/5/26.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: 点击按钮，显示定位
    @IBAction func showMyLocationButtonDidTouch(_ sender: AnyObject) {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //MARK: 属性 自动暂停位置更新
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationLabel.text = "Error while updating location" + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler:  { (placeMarks, error) -> Void in
            
            if (error != nil) {
                self.locationLabel.text = "Reverse geocoder failed with error" + (error!.localizedDescription)
                return
            }
            
            if placeMarks!.count > 0 {
                let PM = placeMarks![0]
                self.showLocationInfo(PM)
            } else {
                self.locationLabel.text = "Problem with the data received from geocoder"
            }
        })
    }
    
    //MARK: 显示位置
    func showLocationInfo(_ placemark: CLPlacemark?) {
        
        if let containsPlacemark = placemark {
            
            locationManager.startUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            self.locationLabel.text = locality! + " " + postalCode! + " " + administrativeArea! + " " + country!
        }
        
    }
    
}

