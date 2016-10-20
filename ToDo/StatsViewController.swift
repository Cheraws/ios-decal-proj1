//
//  StatsViewController.swift
//  ToDo
//
//  Created by Robert Chang on 10/19/16.
//  Copyright © 2016 Bobert. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var statItems =  [Item]()
    var items = [Item](){
        didSet {
            buildStatsList()
        }
    }
    @IBOutlet var statsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stats"
        
        NotificationCenter.default.addObserver(self, selector: #selector(StatsViewController.updateStatsList(_:)), name: NSNotification.Name(rawValue: "StatsListDidChangeNotification"), object: nil)
    
        loadItems()
        //NotificationCenter.default.addObserver(self, selector: #selector(StatsViewController.updateShoppingList(_:)), name: NSNotification.Name(rawValue: "ShoppingListDidChangeNotification"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadItems() {
        if let filePath = pathForItems() , FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
            }
        
        }
    }
    func updateStatsList(_ notification: Notification){
        loadItems()
    }
    fileprivate func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = URL(string: documents) {
            return documentsURL.appendingPathComponent("items").path
        }
        
        return nil
    }
    
    func updateShoppingList(notification: NSNotification) {
        loadItems()
    }
    func buildStatsList(){
        var newStat = [Item]()
        for i in items{
            print("Are we in a loop?")
            
            if (i.checked == true){
                print("something?")
                newStat.append(i)
                
                
            }
        }
        statItems = newStat
        statsLabel.text = String(statItems.count) 
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
