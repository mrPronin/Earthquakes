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
        DispatchQueue.main.async { [weak self] in
            self?.bindUI()
        }
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
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: bag)
        tableView.rx
            .modelSelected((Earthquake.Item).self)
            .subscribe(onNext: { [weak self] model in
                guard let stringSelf = self else { return }
                stringSelf.navigator.show(segue: .earthquakeItem(model), sender: stringSelf)
            })
            .disposed(by: bag)
        // activityIndicator
        _ = self.view.addActivityIndicator(.large)
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
