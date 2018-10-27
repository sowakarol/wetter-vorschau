//
//  WeatherApiService.swift
//  wetter
//
//  Created by karl on 27/10/2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit


class WeatherApiService {

    let weatherEndpoint = "https://www.metaweather.com/api/location/"
    let weatherPhotosEndpoint = "https://www.metaweather.com/static/img/weather/ico/"
    let searchCitiesEndpoint = "https://www.metaweather.com/api/location/search?query="
    
    func getForecastFromCity(city: City, callback: @escaping ((ForecastList?) -> Void)) {
        let session = URLSession(configuration: .default)
        let endpoint = weatherEndpoint + city.woeid
        guard let url = URL(string: endpoint) else {
            print("Error in creating URL for endpoint - " + endpoint)
            return
        }
        
        let task = session.dataTask(with: url){
            (data, response, error) in
            guard error == nil else {
                print("Error in GET for url - " + url.absoluteString)
                return
            }
            
            guard let respData = data else {
                print("Error - did not received response Data!")
                return
            }
            
            guard let weatherData = try? JSONDecoder().decode(ForecastList.self,from:respData) else{
                print("Error in parsing")
                return
            }
            weatherData.city = city
            session.finishTasksAndInvalidate()
            callback(weatherData)
        }
        task.resume()
    }
    
    func getWeatherStatePhoto(state_abbr:String, callback: @escaping ((UIImage?) -> Void)){
        let session = URLSession(configuration: .default)
    
        guard let url = URL(string: weatherPhotosEndpoint + "\(state_abbr).ico") else {
            print("Error in creating URL for Weather State Photos!")
            return
        }
            
        let task = session.dataTask(with: url){
            (data, response, error) in
            guard error == nil else {
                print("Error in GET for Weather State Photos!")
            return
            }
                
            guard let respData = data else {
                print("Error - did not received response Data!")
                return
            }
            callback(UIImage(data: respData))
        }
        task.resume()
    }
    
    func searchForCities(query:String, callback: @escaping (([City]?) -> Void)){
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: searchCitiesEndpoint + query) else {
            print("Error in creating URL for searching cities!")
            return
        }
        
        let task = session.dataTask(with: url){
            (data, response, error) in
            guard error == nil else {
                print("Error in GET for searching cities!")
                return
            }
            
            guard let respData = data else {
                print("Error - did not received response Data!")
                return
            }
            guard let cities = try? JSONDecoder().decode([City].self,from:respData) else{
                print("Error in parsing")
                return
            }
            callback(cities)
        }
        task.resume()
    }
    
    

}