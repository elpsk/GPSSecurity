//
//  TravelCore.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit
import MapKit

internal class TravelTimeManager: NSObject {
    
    private lazy var request = MKDirectionsRequest()
    private var settings: GPSValidatorSettings

    init(settings: GPSValidatorSettings, previousLocation: LocationModel, currentLocation: LocationModel) {
        self.settings = settings

        super.init()

        request.source      = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: previousLocation.latitude, longitude: previousLocation.longitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLocation.latitude,  longitude: currentLocation.longitude),  addressDictionary: nil))

        request.requestsAlternateRoutes = true
        request.transportType = self.settings.travelTransportType
    }

    func getTravelTime( completionHandler: @escaping (TravelModel?) -> Void ) {
        let directions = MKDirections(request: request)
        directions.calculate {(response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    Debug.log(text: error.localizedDescription)
                }
                completionHandler(nil)
                return
            }

            if response.routes.count > 0 {
                let route = response.routes[0]
                let convertedTime = route.expectedTravelTime.toHoursMinutesSeconds()
                let time = TravelModel(hours: convertedTime.hour, minutes: convertedTime.minute, seconds: convertedTime.seconds)
                completionHandler(time)
            }
        }
    }

}
