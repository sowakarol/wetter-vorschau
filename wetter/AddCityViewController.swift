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
    //var newCity:Any
    weak var delegate:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createCitySegue" {
            let controller = segue.destination as! 	MasterViewController
            let newCity = NSDate()
            delegate.updateCitiesArray(newCity: newCity)
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
