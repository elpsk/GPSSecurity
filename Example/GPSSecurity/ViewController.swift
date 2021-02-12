//
//  ViewController.swift
//  GPSSecurity
//
//  Created by alberto.pasca@gmail.com on 02/12/2021.
//  Copyright (c) 2021 alberto.pasca@gmail.com. All rights reserved.
//

import UIKit
import CoreLocation
import GPSSecurity

class ViewController: UIViewController {

    private lazy var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGps()
    }

    private func initializeGps() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: locationManager.startUpdatingLocation()
        default: break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(String(format: "Location: %.2f - %.2f", locations.first!.coordinate.latitude, locations.first!.coordinate.longitude))

        GPSValidator().positionValid(currentPosition: locations.first!) { validLocation in
            print("Can reach this location in a valid time?: \(validLocation)")
        }
    }

}
