//
//  TimeInterval.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

extension TimeInterval {
    
    func toHoursMinutesSeconds() -> (hour: Int, minute: Int, seconds: Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
    
}
