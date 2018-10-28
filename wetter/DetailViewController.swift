//
//  DetailViewController.swift
//  wetter
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var date = Date()
    let formatter = DateFormatter()
    var dateIterator = 0
    var responseDataLength = 0
    
    
    func formatNumberToTextField(_ number:Double) -> String {
        return NSString(format:"%.1f", number) as String
    }
    
    func updateWeatherInfo(forecast:Forecast){
        checkButtons()
        
        WeatherStateImage.image = nil
        LowestTemperatureField.text = "\(formatNumberToTextField(forecast.min_temp)) °C"
        HighestTemperatureField.text = "\(formatNumberToTextField(forecast.max_temp)) °C"
        WindSpeedField.text = "\(formatNumberToTextField(forecast.wind_speed)) km/h"
        WindDirectionField.text = forecast.wind_direction_compass
        PressureField.text = "\(formatNumberToTextField(forecast.air_pressure)) hPa"
        
        WeatherApiService.getWeatherStatePhoto(state_abbr: forecast.weather_state_abbr, callback: {image in
            DispatchQueue.main.async{
                self.WeatherStateImage.image = image
            }
        })
    }
    
    func prepareGui(newDate: String){
        updateDateLabel(newDate: newDate)
        checkButtons()
    }
    
    func updateDateLabel(newDate: String){
        self.DateLabel.text = newDate
    }
    
    func checkButtons(){
        DispatchQueue.main.async{
            if (self.dateIterator <= 0){
                self.PreviousButton.isEnabled = false
            } else {
                self.PreviousButton.isEnabled = true
            }
            if(self.dateIterator == self.responseDataLength - 1){
                self.NextButton.isEnabled = false
            } else {
                self.NextButton.isEnabled = true
            }
        }
    }
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var PreviousButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBAction func onClickPrevious(_ sender: Any){
        dateIterator = dateIterator - 1
        
        let tmpDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        date = tmpDate ?? Date()
        prepareGui(newDate: formatter.string(from:date))
        updateWeatherInfo(forecast: (detailItem?.consolidated_weather[dateIterator])!)
        
    }
    @IBAction func onClickNext(_ sender: Any) {
        dateIterator = dateIterator + 1
        
        let tmpDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        date = tmpDate ?? Date()
        prepareGui(newDate: formatter.string(from: date))
        updateWeatherInfo(forecast: (self.detailItem!.consolidated_weather[dateIterator]))
    }
    @IBOutlet weak var PressureField: UITextField!
    @IBOutlet weak var WindDirectionField: UITextField!
    @IBOutlet weak var WindSpeedField: UITextField!
    @IBOutlet weak var HighestTemperatureField: UITextField!
    @IBOutlet weak var LowestTemperatureField: UITextField!
    
    @IBOutlet weak var WeatherStateImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = self.detailItem?.city?.title
        
        formatter.dateFormat = "yyyy.MM.dd"
        let strDate = formatter.string(from: date)
        self.responseDataLength = (self.detailItem?.consolidated_weather.count)!
        prepareGui(newDate: strDate)
        if((self.detailItem?.consolidated_weather.count)! > 0){
            updateWeatherInfo(forecast: (self.detailItem?.consolidated_weather[0])!)
            
        }
    }
    var detailItem: ForecastList?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let object = detailItem?.city
            let controller = segue.destination as! MapViewController
            
            controller.city = object
        }
    }
    
}


