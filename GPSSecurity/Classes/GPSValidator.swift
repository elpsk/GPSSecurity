//
//  GPSValidator.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit
import CoreLocation
import MapKit

public class GPSValidator {

    private var settings: GPSValidatorSettings = GPSValidatorSettings()

    /**
    Use GPSValidatorSettings if needed, else default values are used:
    - Parameters:
        - settings: GPSValidatorSettings
    */
    public init( settings: GPSValidatorSettings? = nil ) {
        if let settings = settings { self.settings = settings }
    }

    public func positionValid( currentPosition: CLLocation, completionHandler: @escaping (Bool) -> Void ) {
        let locationModel = LocationModel(latitude: currentPosition.coordinate.latitude, longitude: currentPosition.coordinate.longitude)
        ValidatorViewModel(settings: settings).isPositionValid(currentPosition: locationModel, completionHandler: completionHandler)
    }

}
