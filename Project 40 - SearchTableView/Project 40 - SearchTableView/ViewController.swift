//
//  ViewController.swift
//  Project 40 - SearchTableView
//
//  Created by 陈炯 on 16/7/18.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    var data = ["Ferrari", "Lamborghini", "Aston Martin", "Porsche", "Audi", "Benz", "BMW", "Honda", "Toyota", "Land Rover", "Bugatti", "Volkswagen", "Alfa Romeo", "Mini Cooper", "Bently", "Flat"]
    
    var searchResultController = UISearchController(searchResultsController: nil)
    var searchResultData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultController.searchResultsUpdater = self
        searchResultController.dimsBackgroundDuringPresentation = false
        searchResultController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchResultController.searchBar
        
        self.tableView.reloadData()
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.isActive ? searchResultData.count : data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if searchResultController.isActive {
            
            cell.textLabel?.text = searchResultData[indexPath.row]
            return cell
            
        } else {
            
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchResultData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchResultController.searchBar.text!)
        let stringArray = (data as NSArray).filtered(using: searchPredicate)
        searchResultData = stringArray as! [String]
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

