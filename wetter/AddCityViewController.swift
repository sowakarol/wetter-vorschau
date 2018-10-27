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
                self.viewDidAppear(true)
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(foundedCities.count)
        return foundedCities.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let clickedCity = foundedCities[indexPath.row]
//        delegate.updateCitiesArray(newCity: clickedCity)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoundedCityCell", for: indexPath)
        print("title -- " + foundedCities[indexPath.row].title)
        cell.textLabel?.text = foundedCities[indexPath.row].title
        return cell
        
    }
    
    var foundedCities: [City] = []
    @IBOutlet var foundCitiesTableView: UITableView!
//    weak var delegate:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        foundCitiesTableView = UITableView(frame: self.view.bounds, style: .plain)
//        foundCitiesTableView.dataSource = self
//        foundCitiesTableView.delegate = self
//        self.view.addSubview(foundCitiesTableView)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.foundCitiesTableView.reloadData()
    }

}
