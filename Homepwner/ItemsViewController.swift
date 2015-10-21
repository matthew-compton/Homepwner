//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Matthew Compton on 10/20/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
 
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
        ) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        cell.updateLabels()
            
        let item = itemStore.allItems[indexPath.row]
        
        // Configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                let item = itemStore.allItems[indexPath.row]
                
                let ac = UIAlertController(
                    title: "Delete \(item.name)?",
                    message: "Are you sure you want to delete this item?",
                    preferredStyle: .ActionSheet
                )
                
                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: .Cancel,
                    handler: nil
                )
                let deleteAction = UIAlertAction(
                    title: "Delete",
                    style: .Destructive,
                    handler: {
                        (action) -> Void in
                        self.itemStore.removeItem(item)
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    }
                )
                ac.addAction(cancelAction)
                ac.addAction(deleteAction)
                
                presentViewController(ac, animated: true, completion: nil)
            }
    }
    
    override func tableView(tableView: UITableView,
        moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath) {
            itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(
        tableView: UITableView,
        titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath
        ) -> String? {
            return "Remove"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}
