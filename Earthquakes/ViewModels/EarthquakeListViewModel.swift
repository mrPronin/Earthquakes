//
//  EarthquakeListViewModel.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation
import RxSwift

protocol EarthquakeListViewModelProtocol {
    var data: Observable<[Earthquake.Item]> { get }
}

struct EarthquakeListViewModel: EarthquakeListViewModelProtocol {
    // MARK: - Init
    init(boundingCoordinates: GeonamesAPI.BoundingCoordinates, user: String, apiType: GeonamesAPIProtocol.Type = GeonamesAPI.self) {
        self.boundingCoordinates = boundingCoordinates
        self.user = user
        self.apiType = apiType
        bindOutput()
    }
    // MARK: - Input
    private let boundingCoordinates: GeonamesAPI.BoundingCoordinates
    private let user: String
    // MARK: - Output
    private let dataSubject: BehaviorSubject<[Earthquake.Item]> = BehaviorSubject(value: [])
    var data: Observable<[Earthquake.Item]> { dataSubject.asObservable() }
    // MARK: - Private
    private let bag = DisposeBag()
    private let apiType: GeonamesAPIProtocol.Type
    private func bindOutput() {
        apiType.earthquakes(with: boundingCoordinates, user: user)
        .bind(to: dataSubject)
        .disposed(by: bag)
    }
}
