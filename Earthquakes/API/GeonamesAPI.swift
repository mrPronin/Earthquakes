//
//  GeonamesAPI.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 07.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GeonamesAPIProtocol {
    static func earthquakes(with coordinates: GeonamesAPI.BoundingCoordinates) -> Observable<Earthquake>
}

// http://api.geonames.org/earthquakesJSON?formatted=true&north=44.1&south=-9.9&east=-22.4&west=55.2&username=mkoppelman
struct GeonamesAPI: GeonamesAPIProtocol {
    // MARK: - Input Models
    struct BoundingCoordinates {
        let north: Double
        let south: Double
        let east: Double
        let west: Double
    }
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case earthquakes = "earthquakesJSON"
        private var baseURL: String {
            return "http://api.geonames.org/"
        }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
        case invalidURL
    }
    // MARK: - API Endpoint Requests
    static func earthquakes(with coordinates: GeonamesAPI.BoundingCoordinates) -> Observable<Earthquake> {
        return getRequest(address: .earthquakes, parameters: [:])
        .map { data in
          let decoder = JSONDecoder()
          return try decoder.decode(Earthquake.self, from: data)
        }

    }
    private static func getRequest(address: Address, parameters: [String: String] = [:]) -> Observable<Data> {
        var urlComponents = URLComponents(string: address.url.absoluteString)!
        urlComponents.queryItems = parameters.sorted { $0.0 < $1.0 }.map(URLQueryItem.init)
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.url = url
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return URLSession.shared.rx.data(request: request)
    }
}
