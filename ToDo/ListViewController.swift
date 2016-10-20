//
//  ListViewController.swift
//  ToDo
//
//  Created by Robert Chang on 10/16/16.
//  Copyright © 2016 Bobert. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,AddItemViewControllerDelegate {

    var items = [Item]()
    
    let CellIdentifier = "Cell Identifier"
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadItems()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Items"
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        //add the button.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UIPushBehavior.addItem(_:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ListViewController.editItems(_:)))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func editItems(_ sender:UIBarButtonItem){
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
   
    //for delegate.
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andDoing doing: String) {
        // Create Item
        print(name)
        print("name and string")
        print(doing)
        let item = Item(name: name, doing: doing)
        
        // Add Item to Items
        items.append(item)
        // Add Row to Table View
        tableView.insertRows(at: [IndexPath(row: (items.count - 1), section: 0)], with: .none)
        
        // Save Items
        saveItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destination as? UINavigationController,
                let addItemViewController = navigationController.viewControllers.first as? AddItemViewController {
                addItemViewController.delegate = self
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        // Fetch Item
        let item = items[(indexPath as NSIndexPath).row]
        
        // Configure Table View Cell
        cell.textLabel?.text = item.name
        if(item.checked){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        item.checked = !item.checked
        if(item.checked){
            cell?.accessoryType = .checkmark
        }
        else{
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }
        items[indexPath.row] = item
        print(item.checked)
        print("Flipped?")
        saveItems()
    }
    
    
    func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddItemViewController", sender: self)
    }
    
    fileprivate func loadItems() {
        if let filePath = pathForItems() , FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
                items = items.filter(){Date().timeIntervalSince($0.date) < 84000}
            }
        }
        
    }

    private func saveItems() {
        //make sure that it resets for the 24 hr.
        items = items.filter(){Date().timeIntervalSince($0.date) < 84000}
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StatsListDidChangeNotification"), object: self)

    }
    
    fileprivate func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = URL(string: documents) {
            return documentsURL.appendingPathComponent("items").path
        }
        
        return nil
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            saveItems()
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
