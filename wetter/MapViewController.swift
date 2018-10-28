//
//  MapViewController.swift
//  wetter
//
//  Created by karl on 28/10/2018.
//  Copyright © 2018 karl. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MapViewController: UIViewController {

    var city:City? = nil
    
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = (self.city?.title)! + " map"
        let coords = self.city?.latt_long.components(separatedBy: ",")
        let coordinate = CLLocationCoordinate2D(latitude: Double(coords![0])!, longitude: Double(coords![1])!)
        self.MapView.setCenter(coordinate, animated: true)
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
