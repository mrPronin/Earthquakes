//
//  EarthquakeMapViewModel.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol EarthquakeMapViewModelProtocol {
    var model: Earthquake.Item { get }
}

struct EarthquakeMapViewModel: EarthquakeMapViewModelProtocol {
    // MARK: - Init
    init(model: Earthquake.Item, apiType: GeonamesAPIProtocol.Type = GeonamesAPI.self) {
        self.model = model
        self.apiType = apiType
    }
    // MARK: - Input
    let model: Earthquake.Item
    // MARK: - Output
    // MARK: - Private
    private let bag = DisposeBag()
    private let apiType: GeonamesAPIProtocol.Type
    private func bindOutput() {
    }
}
