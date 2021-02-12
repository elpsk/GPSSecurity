//
//  TravelRules.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

internal class ValidatorViewModel {

    private var localStorage: LocalStorageManager
    private var settings: GPSValidatorSettings

    init(settings: GPSValidatorSettings) {
        self.settings = settings
        self.localStorage = LocalStorageManager(settings: settings)
    }

    func isPositionValid( currentPosition: LocationModel, completionHandler: @escaping (Bool) -> Void ) {
        if let storedUserLocation = localStorage.getLastStoredLocation() {
            travelTimeValidator(storedData: storedUserLocation, toLocation: currentPosition) { valid in
                completionHandler(valid)
            }
        } else {
            completionHandler(true)
        }

        localStorage.updateStoredLocationIfNeeded(currentCoordinate: currentPosition)
    }

    // ---------------------------------------------------------------------------------------------

    private func travelTimeValidator( storedData: StoredPositionsModel, toLocation: LocationModel, completionHandler: @escaping (Bool) -> Void ) {
        let storedLocation = LocationModel(latitude: storedData.latitude, longitude: storedData.longitude)
        let travel = TravelTimeManager(settings: settings, previousLocation: storedLocation, currentLocation: toLocation)

        travel.getTravelTime { extimatedTime in
            if let travelExtimationTime = extimatedTime {
                Debug.log(text: "TRAVEL TIME  : \(travelExtimationTime.hours)h : \(travelExtimationTime.minutes) mins" )
                Debug.log(text: "LATEST UPDATE: \(storedData.latestDateStored.timeAgo().hours)h : \(storedData.latestDateStored.timeAgo().minutes) mins" )

                completionHandler(self.validTime(travelExtimationTime: travelExtimationTime, storedData: storedData))
            } else {
                Debug.log(text: "too far away or unable to fetch..." )
                completionHandler(false)
            }
        }
    }
    
    private func validTime( travelExtimationTime: TravelModel, storedData: StoredPositionsModel ) -> Bool {
        if travelExtimationTime.hours == 0 && travelExtimationTime.minutes == 0 {
            return true
        } else if travelExtimationTime.hours == storedData.latestDateStored.timeAgo().hours {
            if travelExtimationTime.minutes + (settings.deltaTravelTimeMinutes) > storedData.latestDateStored.timeAgo().minutes {
                return false
            }
        } else if travelExtimationTime.hours > storedData.latestDateStored.timeAgo().hours {
            return false
        }
        
        return true
    }

}
