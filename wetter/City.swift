//
//  City.swift
//  wetter
//
//  Created by karl on 26/10/2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit

class City: NSObject, Decodable {
    var title:String
    var woeid:Int
    var latt_long:String
    
    init(title: String, woeid: Int, latt_long: String){
        self.title = title
        self.woeid = woeid
        self.latt_long = latt_long
    }
}
