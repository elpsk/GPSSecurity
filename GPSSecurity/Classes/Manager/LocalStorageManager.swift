//
//  LocalStorage.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit
import KeychainSwift

internal class LocalStorageManager {
    
    private lazy var keychain = KeychainSwift()
    private var settings: GPSValidatorSettings

    init(settings: GPSValidatorSettings) {
        self.settings = settings
    }

    func updateStoredLocationIfNeeded( currentCoordinate: LocationModel ) {
        if let storedData = getLastStoredLocation() {
            if abs(storedData.latestDateStored.timeAgo().hours) >= settings.refreshLocalPositionTime {
                saveData(currentCoordinate: currentCoordinate)
            }
        } else {
            saveData(currentCoordinate: currentCoordinate)
        }
    }

    func getLastStoredLocation() -> StoredPositionsModel? {
        if let storedData = keychain.getData(Constants.keychainDataKey) {
            let decoder = JSONDecoder()
            if let dataModel = try? decoder.decode(StoredPositionsModel.self, from: storedData) {
                return dataModel
            }
        }
        return nil
    }

    private func saveData( currentCoordinate: LocationModel ) {
        let encoder = JSONEncoder()

        let positionModel = StoredPositionsModel(
            latitude: currentCoordinate.latitude,
            longitude: currentCoordinate.longitude,
            latestDateStored: Date()
        )

        if let encoded = try? encoder.encode(positionModel) {
            keychain.set(encoded, forKey: Constants.keychainDataKey)
        }
    }
    
}
