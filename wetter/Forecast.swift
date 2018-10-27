//
//  Forecast.swift
//  wetter
//
//  Created by karl on 26/10/2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class Forecast: NSObject, Decodable {
    var min_temp:Double
    var max_temp:Double
    var wind_speed:Double
    var wind_direction_compass:String
    var air_pressure:Double
    var weather_state_abbr: String
}
