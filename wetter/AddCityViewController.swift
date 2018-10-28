//
//  AddCityViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit
import MapKit

class AddCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var CityName: UITextField!
    
    @IBAction func MyLocationButtonClicked(_ sender: Any) {
        let latitude = locationManager.location?.coordinate.latitude
        print(latitude as Any)
        let longitude = locationManager.location?.coordinate.longitude
        print(longitude as Any)
        WeatherApiService.searchForCitiesByCoords(latitude:latitude!, longitude: longitude!, callback:{
            cities in
            self.updateCities(cities: cities!)
        })
    }
    @IBAction func SearchButtonClicked(_ sender: Any) {
        WeatherApiService.searchForCities(query: CityName.text!, callback: { cities in
            self.updateCities(cities: cities!)
        })
    }
    func updateCities(cities: [City]){
        self.foundedCities.removeAll()
        for city in cities {
            print(city.title)
            self.foundedCities.append(city)
        }
        DispatchQueue.main.async{
            self.foundCitiesTableView.reloadData()
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
        print(locations)
        guard let lastLocation = locations.last else {
            return
        }
        print(lastLocation.coordinate)
        print(lastLocation.speed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
}
