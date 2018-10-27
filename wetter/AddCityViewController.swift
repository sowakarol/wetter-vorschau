//
//  AddCityViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundCities.count
    }
    
    @IBOutlet weak var FoundCityCell: UIView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foundCityCell", for: indexPath)
        cell.textLabel?.text = foundCities[indexPath.row] as? String
        return cell
        
    }
    
    var foundCities = [Any]()
    @IBOutlet weak var foundCitiesTableView: UITableView!
    var objects = [Any]()
    //var newCity:Any
    weak var delegate:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foundCities.insert("Frankfurt", at: 0)
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
