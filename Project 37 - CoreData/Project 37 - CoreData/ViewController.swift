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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ViewController.addNewItem))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "List")
        
        do {
            
            let results = try manageContext.fetch(fetchRequest)
            listItems = results as! [NSManagedObject]
            self.tableView.reloadData()
            
        } catch {
            
            print("error")
        }
    }

    func addNewItem() {
        
        let alertController = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: UIAlertControllerStyle.alert)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField {
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addTextField (configurationHandler: {
            (textField) in
            
            textField.placeholder = "Input your new item"
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func saveItem(_ itemToSave: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "List", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
        do {
            
            try managedContext.save()
            listItems.append(item)
            
        } catch {
            
            print("error")
            
        }
        
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let item = listItems[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.value(forKey: "item") as? String
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Delete") { (action, index) -> Void in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            tableView.reloadRows(at: [indexPath], with: .fade)
            managedContext.delete(self.listItems[(indexPath as NSIndexPath).row])
            do {
                
                try managedContext.save()
                self.listItems.remove(at: (indexPath as NSIndexPath).row)
                self.tableView.reloadData()
                
            } catch {
                
                print("error")
            }
            
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

