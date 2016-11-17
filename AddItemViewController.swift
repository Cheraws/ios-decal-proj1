//
//  AddItemViewController.swift
//  ToDo
//
//  Created by Robert Chang on 10/16/16.
//  Copyright © 2016 Bobert. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andDoing doing:String)
}

class AddItemViewController: UIViewController {
    var delegate: AddItemViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let name = nameTextField.text
        let doing = priceTextField.text
        
        delegate?.controller(controller: self, didSaveItemWithName: name!, andDoing: doing!)
            
        // Dismiss View Controller
        dismiss(animated: true, completion: nil)
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
