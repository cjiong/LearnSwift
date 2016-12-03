//
//  ViewController.swift
//  Project 35 - SimpleWeatherReport
//
//  Created by 陈炯 on 16/7/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

struct Weather {
    var city: String?
    var weather: String?
    var temp: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    
    var weatherData: Weather? {
        didSet {
            configView()
        }
    }
    
    func configView() {
        labelCity.text = self.weatherData?.city
        labelWeather.text = self.weatherData?.weather
        labelTemp.text = self.weatherData?.temp
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData()
    }
    
    func getWeatherData() {
        
        let url  = URL(string: "http://api.k780.com:88/?app=weather.today&weaid=173&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
        
        //MARK: 会话配置
        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest = 10
        
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!, completionHandler: { (data, _, error) -> Void in
            
            if error == nil {
                if let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments))
                    as? NSDictionary {
                        
                        //MARK: JSON解析
                        let weather = (json.value(forKey: "result") as? NSDictionary).map {
                            Weather(city: $0["citynm"] as? String,
                                weather: $0["weather"] as? String,
                                temp: $0["temperature_curr"] as? String)
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.weatherData = weather
                        })
                        
                        
                }
            }
            
        })
        
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

