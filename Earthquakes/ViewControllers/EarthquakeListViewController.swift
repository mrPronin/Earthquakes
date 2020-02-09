//
//  EarthquakeListViewController.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 07.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EarthquakeListViewController: UIViewController {
    // MARK: - Public API
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindUI()
    }
    // MARK: - Private
    @IBOutlet weak var tableView: UITableView!
    private let bag = DisposeBag()
    var viewModel: EarthquakeListViewModelProtocol!
    var navigator: NavigatorProtocol!
}
// MARK: - Private
extension EarthquakeListViewController {
    internal func bindUI() {
        viewModel.data
            .bind(to: tableView.rx.items) { (_, _, element: Earthquake.Item) in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = element.id
                return cell
            }
            .disposed(by: bag)
    }
    internal func setupOnLoad() {
        title = "Earthquakes list".localized
        /*
        let boundingCoordinates = GeonamesAPI.BoundingCoordinates(north: 44.1, south: -9.9, east: -22.4, west: 55.2)
        view.showActivityIndicator()
        GeonamesAPI.earthquakes(with: boundingCoordinates, user: "mkoppelman")
            .subscribe(onNext: { [weak self] in
            $0.forEach { [weak self] in
                print("[\(type(of: self)) \(#function)] \($0)")
                self?.view.hideActivityIndicator()
            }
        })
        .disposed(by: bag)
        */
    }
}
