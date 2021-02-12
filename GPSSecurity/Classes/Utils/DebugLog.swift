//
//  DebugLog.swift
//  GPSSecurity
//
//  Created by Pasca Alberto, IT on 12/02/21.
//

import UIKit

internal class Debug {

    private init() {}
    public static func log( prefix: String = #file, text: String ) {
        let fileName = prefix.components(separatedBy: "/").last!
        print( "\(fileName) => \(text)" )
    }

}
