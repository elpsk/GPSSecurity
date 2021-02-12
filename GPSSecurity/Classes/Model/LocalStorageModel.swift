//
//  LocalStorageModel.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

internal struct StoredPositionsModel: Codable {
    var latitude : Double
    var longitude: Double
    var latestDateStored : Date
}
