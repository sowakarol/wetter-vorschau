//
//  AddCityViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {

    var objects = [Any]()
    weak var delegate:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddButton(_ sender: Any) {
        print(objects)
        objects.insert(NSDate(), at: 0)
       
        print(objects)
        delegate.updateCitiesArray(newArray: objects)

    }
    
    @IBAction func CancelAddingCity(_ sender: Any) {
    }
    @objc
    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createCitySegue" {
            let controller = segue.destination as! MasterViewController
            //controller.objects = objects
            objects.insert(NSDate(), at: 0)
            delegate.updateCitiesArray(newArray: objects)
            //            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            //            controller.navigationItem.leftItemsSupplementBackButton = true
            print("abcd")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
