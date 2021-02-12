//
//  CLLocation.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import CoreLocation

extension CLLocation {
    
    func distance( to: CLLocation ) -> CLLocationDistance {
        return self.distance(from: to) // mt
    }

}
