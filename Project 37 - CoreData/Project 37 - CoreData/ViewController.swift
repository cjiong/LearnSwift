//
//  ViewController.swift
//  Project 37 - CoreData
//
//  Created by 陈炯 on 16/7/14.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var listItems = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewItem")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "List")
        
        do {
            
            let results = try manageContext.executeFetchRequest(fetchRequest)
            listItems = results as! [NSManagedObject]
            self.tableView.reloadData()
            
        } catch {
            
            print("error")
        }
    }

    func addNewItem() {
        
        let alertController = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: UIAlertControllerStyle.Alert)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField {
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler ({
            (textField) in
            
            textField.placeholder = "Input your new item"
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func saveItem(itemToSave: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: managedContext)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
        do {
            
            try managedContext.save()
            listItems.append(item)
            
        } catch {
            
            print("error")
            
        }
        
    }
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item.valueForKey("item") as? String
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Delete") { (action, index) -> Void in
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            managedContext.deleteObject(self.listItems[indexPath.row])
            do {
                
                try managedContext.save()
                self.listItems.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
                
            } catch {
                
                print("error")
            }
            
        }
        delete.backgroundColor = UIColor.redColor()
        
        return [delete]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

