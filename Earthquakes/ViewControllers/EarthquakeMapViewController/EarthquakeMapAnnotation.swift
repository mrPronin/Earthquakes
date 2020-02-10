//
//  EarthquakeMapAnnotation.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import MapKit

class EarthquakeMapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

extension EarthquakeMapAnnotation {
    convenience init(model: Earthquake.Item) {
        self.init(title: "Magnitude: \(model.magnitude)", subtitle: "Date: \(DateFormatter.display.string(from: model.date))", coordinate: model.coordinate)
    }
}
