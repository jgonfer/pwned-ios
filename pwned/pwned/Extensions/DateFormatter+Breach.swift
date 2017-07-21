//
//  DateFormatter+Breach.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation

extension DateFormatter {
    // provide formatter suitable to parse tweet dates
    static let breach = DateFormatter(dateFormat: "EEE MMM dd HH:mm:ss Z yyyy")
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
