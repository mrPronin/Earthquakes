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
    // MARK: - Public
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.bindUI()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        _ = self.view.addActivityIndicator(.large)
        viewModel.data
            .bind(to: tableView.rx.items) { (_, _, element: Earthquake.Item) in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = element.id
                return cell
            }
            .disposed(by: bag)
        let running = viewModel.data
            .filter { !$0.isEmpty }
            .map { _ in false }
            .startWith(true)
            .asDriver(onErrorJustReturn: false)
        running
            .drive(self.view.activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        running
            .drive(tableView.rx.isHidden)
            .disposed(by: bag)
    }
    internal func setupOnLoad() {
        title = "Earthquakes list".localized
        tableView.tableFooterView = UIView()
    }
}
