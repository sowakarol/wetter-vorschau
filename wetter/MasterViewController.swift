//
//  MasterViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var forecastLists = [ForecastList]()
    
    let munichId = 676757
    let berlinId = 638242
    let warsawId = 523920
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let warsaw = City(title: "Warsaw", woeid: warsawId, latt_long: "52.235352,21.009390")
        let berlin = City(title: "Berlin", woeid: berlinId, latt_long: "52.516071,13.376980")
        let munich = City(title: "Munich", woeid: munichId, latt_long: "48.136410,11.577530")
        initForecastList(cityArray: [warsaw, berlin, munich])
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func initForecastList(cityArray:[City]){
        for city in cityArray {
            WeatherApiService.getForecastFromCity(city: city, callback: {forecastList in
                self.addForecastList(forecastList: forecastList!)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues
    
    @IBAction func cancel(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func createCity(segue: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = forecastLists[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addCitySegue" {
            let controller = segue.destination as! AddCityViewController
            controller.delegate = self
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let forecastList = forecastLists[indexPath.row]
        cell.textLabel!.text = forecastList.city?.title
        print(forecastList.city?.title ?? "")
        cell.detailTextLabel!.text = "\(formatNumberToTextField(forecastList.consolidated_weather[0].the_temp)) °C"
        print(forecastList.consolidated_weather[0].the_temp)
        WeatherApiService.getWeatherStatePhoto(state_abbr: forecastList.consolidated_weather[0].weather_state_abbr, callback: {image in
            DispatchQueue.main.async{
                cell.imageView!.image = image
            }
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func formatNumberToTextField(_ number:Double) -> String {
        return NSString(format:"%.1f", number) as String
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            forecastLists.remove(at: indexPath.row)
            self.tableView.reloadData()
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func addForecastList(forecastList: ForecastList){
        DispatchQueue.main.async{
            self.forecastLists.insert(forecastList, at: 0)
            self.tableView.reloadData()
            //            let indexPath = IndexPath(row: 0, section: 0)
            //            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateCitiesArray(newCity: City){
        print(newCity.woeid)
        WeatherApiService.getForecastFromCity(city: newCity, callback: { forecastList in
            self.addForecastList(forecastList: forecastList!)
        })
    }
    
}


