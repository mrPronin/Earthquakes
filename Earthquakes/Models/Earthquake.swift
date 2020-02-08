//
//  Earthquake.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 07.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation
import CoreLocation

struct Earthquake {
    struct Root: Decodable {
        let earthquakes: [Item]
    }
    struct Item: Decodable {
        let id: String
        let depth: Double
        let magnitude: Double
        let src: String
        let date: Date
        let coordinate: CLLocationCoordinate2D
        enum CodingKeys: String, CodingKey {
            case id = "eqid"
            case depth
            case magnitude
            case src
            case date = "datetime"
            case lng
            case lat
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            depth = try container.decode(Double.self, forKey: .depth)
            magnitude = try container.decode(Double.self, forKey: .magnitude)
            src = try container.decode(String.self, forKey: .src)
            date = try container.decode(Date.self, forKey: .date)
            let latitude = try container.decode(CLLocationDegrees.self, forKey: .lat)
            let longitude = try container.decode(CLLocationDegrees.self, forKey: .lng)
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
