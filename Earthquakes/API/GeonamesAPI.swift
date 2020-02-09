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
    static func earthquakes(with coordinates: GeonamesAPI.BoundingCoordinates, user: String) -> Observable<[Earthquake.Item]>
}

typealias JSONObject = [String: Any]

// http://api.geonames.org/earthquakesJSON?formatted=true&north=44.1&south=-9.9&east=-22.4&west=55.2&username=mkoppelman
struct GeonamesAPI: GeonamesAPIProtocol {
    // MARK: - Input Models
    struct BoundingCoordinates {
        let north: Double
        let south: Double
        let east: Double
        let west: Double
        var dictionary: [String: String] {
            let mirror = Mirror(reflecting: self)
            let dictionary = mirror.children.compactMap { (label, value) -> (String, Double)? in
                guard let label = label else { return nil }
                guard let value = value as? Double else { return nil }
                return (label, value)
            }
            .reduce(into: [:], { $0[$1.0] = String($1.1) })
            return dictionary
        }
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
    static func earthquakes(with coordinates: GeonamesAPI.BoundingCoordinates, user: String) -> Observable<[Earthquake.Item]> {
        var parameters = coordinates.dictionary
        parameters["formatted"] = "true"
        parameters["username"] = user
        return getRequest(address: .earthquakes, parameters: parameters)
            // delay for debug purposes
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .map { data in
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject {
//                    print("json: \(json)")
//                }
                // test
                /*
                do {
                    let testBundle = Bundle.main
                    let path = testBundle.path(forResource: "earthquakes", ofType: "json")!
                    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? JSONObject {
                        print("json: \(json)")
                    }
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.geonames)
                    if let models = try? decoder.decode((Earthquake.Root).self, from: data!) {
                        print("models: \(models)")
                    }
                }
                */
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.geonames)
                return try decoder.decode((Earthquake.Root).self, from: data).earthquakes
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
