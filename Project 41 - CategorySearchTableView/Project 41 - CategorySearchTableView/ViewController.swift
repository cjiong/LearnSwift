//
//  ViewController.swift
//  Project 41 - CategorySearchTableView
//
//  Created by 陈炯 on 16/7/19.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var data = [
        Car(country: "Germany", brand: "Mercedes Benz"), Car(country: "Germany", brand: "BMW"),
        Car(country: "Germany", brand: "Audi"), Car(country: "Germany", brand: "Volkswagen"),
        Car(country: "American", brand: "Ford"), Car(country: "American", brand: "Chevrolet"),
        Car(country: "American", brand: "Hummer"), Car(country: "American", brand: "Lincoln"),
        Car(country: "England", brand: "Range Rover"), Car(country: "England", brand: "Bently"),
        Car(country: "England", brand: "Aston Martin"), Car(country: "England", brand: "Jaguar"),
        Car(country: "Italy", brand: "Lamborghini"), Car(country: "Italy", brand: "Ferrari"),
        Car(country: "Italy", brand: "Maserati"), Car(country: "Italy", brand: "Alfa Romeo")
        
     ]

    var resultdata: [Car] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["Germany", "American", "England", "Italy"]
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: tableview datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            
            return resultdata.count
            
        } else {
            
            return data.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CarCell
        
        let currentCar: Car
        if searchController.active && searchController.searchBar.text != "" {
            
            currentCar = resultdata[indexPath.row]
        } else {
            
            currentCar = data[indexPath.row]
        }
        
        cell.brandLabel.text = currentCar.brand
        cell.countryLabel.text = currentCar.country
        
        return cell
    }
    
    
    //MARK: UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searhBar = searchController.searchBar
        let scope = searhBar.scopeButtonTitles![searhBar.selectedScopeButtonIndex]
        
        search(searchController.searchBar.text!, scope: scope)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        search(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func search(searchText: String, scope: String) {
        
        resultdata = data.filter { Car in
            
            return Car.country == scope && Car.brand.lowercaseString.containsString(searchText.lowercaseString)
        }
        
       tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}







