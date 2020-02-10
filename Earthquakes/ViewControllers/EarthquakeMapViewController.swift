//
//  EarthquakeMapViewController.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit
import RxSwift
import MapKit

class EarthquakeMapViewController: UIViewController {
    // MARK: - Public
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
        DispatchQueue.main.async { [weak self] in
            self?.bindUI()
        }
    }
    // MARK: - Private
    @IBOutlet weak var mapView: MKMapView!
    private let bag = DisposeBag()
    var viewModel: EarthquakeMapViewModelProtocol!
    var navigator: NavigatorProtocol!
    private let regionRadius: CLLocationDistance = 1000 * 1000
}
// MARK: - Private
extension EarthquakeMapViewController {
    internal func bindUI() {
        mapView.addAnnotation(EarthquakeMapAnnotation(model: viewModel.model))
        let coordinateRegion = MKCoordinateRegion(center: viewModel.model.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    internal func setupOnLoad() {
        title = "Earthquake map".localized
    }
}
