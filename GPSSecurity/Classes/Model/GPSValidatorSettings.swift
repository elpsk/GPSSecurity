//
//  GPSValidatorSettings.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

public struct GPSValidatorSettings {

    /// Override stored position time (in Hours), default: 6
    public var refreshLocalPositionTime = 6
    
    /// Delta to add on auto-calculated travel time, default: 0
    public var deltaTravelTimeMinutes = 0

    /// Default transport type used in route calculation, default: .automobile
    public var travelTransportType: MKDirectionsTransportType = .automobile

    public init() {}

}
