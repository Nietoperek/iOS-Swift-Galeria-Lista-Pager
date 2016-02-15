//
//  TableViewController.swift
//  Tutorial
//
//  Created by student on 14.02.2016.
//  Copyright © 2016 PWr. All rights reserved.
//

import UIKit

class GalleryListView: UITableViewController {
    
    let textsArray = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7", "Label 8"]
    let imagesArray = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"),UIImage(named: "8")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
  

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return textsArray.count
    }
        
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath)
        
        let imageView = cell.imageView
        let label = cell.textLabel
        
        imageView!.image = imagesArray[indexPath.row]
        label!.text = textsArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailsSegue"
        {
            // pobranie indeksu zaznaczonej komórki
            let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
            
            // docelowy ViewController
            let destVC = segue.destinationViewController as! DetailsViewController
            
            // przekazanie wartości do docelowego VC
            destVC.parentIndex = indexPath.row+1
        }
    }
}
