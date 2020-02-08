//
//  DateFormatter+GeonamesAPI.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 08.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let geonames: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
