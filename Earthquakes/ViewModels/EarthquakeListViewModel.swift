//
//  EarthquakeListViewModel.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation
import RxSwift

struct EarthquakeListDisplayedModel {
    struct Item: DisplayedItemProtocol, DisplayedItemHasIconImage, DisplayedItemHasTitle, DisplayedItemHasSubtitle, DisplayedItemHasEarthquakeModel {
        var viewType: ConfigurableView.Type = EarthquakeListCell.self
        // DisplayedItemHasIconImage
        var iconImage: UIImage?
        // DisplayedItemHasTitle
        var title: String?
        // DisplayedItemHasSubtitle
        var subtitle: String?
        // DisplayedItemHasEarthquakeModel
        let model: Earthquake.Item
        init(_ model: Earthquake.Item) {
            self.model = model
            if model.magnitude >= 8 {
                self.iconImage = UIImage(named: "ic_severe_destruction")
            } else if model.magnitude >= 7 {
                self.iconImage = UIImage(named: "ic_moderate_destruction")
            } else {
                self.iconImage = UIImage(named: "ic_minor_destruction")
            }
            self.title = "\("Magnitude".localized): \(model.magnitude)"
            self.subtitle = "\("Date".localized): \(DateFormatter.display.string(from: model.date))"
        }
    }
}

protocol EarthquakeListViewModelProtocol {
    var data: Observable<[DisplayedItemProtocol]> { get }
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
    private let dataSubject: BehaviorSubject<[DisplayedItemProtocol]> = BehaviorSubject(value: [])
    var data: Observable<[DisplayedItemProtocol]> { dataSubject.asObservable() }
    // MARK: - Private
    private let bag = DisposeBag()
    private let apiType: GeonamesAPIProtocol.Type
    private func bindOutput() {
        apiType.earthquakes(with: boundingCoordinates, user: user)
            .map { $0.map(EarthquakeListDisplayedModel.Item.init) }
            .bind(to: dataSubject)
            .disposed(by: bag)
    }
}
