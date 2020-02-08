//
//  EarthquakeListViewController.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 07.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit
import RxSwift

class EarthquakeListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let boundingCoordinates = GeonamesAPI.BoundingCoordinates(north: 44.1, south: -9.9, east: -22.4, west: 55.2)
        self.view.showActivityIndicator()
        GeonamesAPI.earthquakes(with: boundingCoordinates, user: "mkoppelman")
            .subscribe(onNext: { [weak self] in
            $0.forEach { [weak self] in
                print("[\(type(of: self)) \(#function)] \($0)")
                self?.view.hideActivityIndicator()
            }
        })
        .disposed(by: bag)
    }
    private let bag = DisposeBag()
}
