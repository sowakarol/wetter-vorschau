//
//  ListForecast.swift
//  wetter
//
//  Created by karl on 26/10/2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class ForecastList: NSObject, Decodable {
    var consolidated_weather: [Forecast] = []
    var city:City? = nil
}
