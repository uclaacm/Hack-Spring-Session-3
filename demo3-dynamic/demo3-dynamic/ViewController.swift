//
//  ViewController.swift
//  demo3-dynamic
//
//  Created by Jahan Cherian on 4/23/17.
//  Copyright © 2017 Jahan Cherian. All rights reserved.
//

import UIKit

// This View Controller holds the Table View

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    
    // Fill up the Table View with the items in here
    var items: [TodoItem] = []
    
    // Go to the next view controller - SecondViewController
    @IBAction func addItem(_ sender: Any) {
        performSegue(withIdentifier: "addItem", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Important to set the delegate to this class
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    // Only 1 section required to hold all our data
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // For iOS to figure out how many rows the TableView needs - the numebr of items we have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // For iOS to figure out what content to display at each row - given by indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        cell.imageView?.image = item.image
        
        return cell
    }

    // For iOS to figure out how tall each row should be
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // This method below allows us to receive data back from another view controllers
    // This is run when SecondViewController unwinds the segue that lead to it - addItem segue
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        // Get access to the variables from the other view controller
        if let svc = sender.source as? SecondViewController {
            if let title = svc.itemTitle.text, let subtitle = svc.itemSubtitle.text, let image = svc.itemImage.image {
                print("Subtitle: \(subtitle)")
                items.append(TodoItem(title: title, subtitle: subtitle, image: image))
            }
            myTable.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

