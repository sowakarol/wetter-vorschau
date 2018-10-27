//
//  AddCityViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var CityName: UITextField!
    
    @IBAction func SearchButtonClicked(_ sender: Any) {
        WeatherApiService.searchForCities(query: CityName.text!, callback: { cities in
            self.foundedCities.removeAll()
            for city in cities! {
                print(city.title)
                self.foundedCities.append(city)
            }
            DispatchQueue.main.async{
                self.foundCitiesTableView.reloadData()
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundedCities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row >= self.foundedCities.count){
            return
        }
        let clickedCity = self.foundedCities[indexPath.row]
        delegate.updateCitiesArray(newCity: clickedCity)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoundedCityCell", for: indexPath)
        cell.textLabel?.text = foundedCities[indexPath.row].title
        return cell
        
    }
    
    var foundedCities: [City] = []
    @IBOutlet var foundCitiesTableView: UITableView!
    weak var delegate:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
