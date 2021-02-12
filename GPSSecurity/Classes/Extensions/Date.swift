//
//  Date.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

extension Date {

    func timeAgo() -> (hours: Int, minutes: Int) {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: Date(), to: self)
        return (abs(diffComponents.hour ?? 0), abs(diffComponents.minute ?? 0))
    }

}
