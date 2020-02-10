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

class EarthquakeListViewController: BaseViewController {
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
// MARK: - UITableViewDelegate
extension EarthquakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EarthquakeListCell.height()
    }
}
// MARK: - Private
extension EarthquakeListViewController {
    internal func bindUI() {
        viewModel.data
            .bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, model: DisplayedItemProtocol) in
                guard let viewType = model.viewType as? BaseTableViewCell.Type else {
                    fatalError("Expect BaseTableViewCell")
                }
                guard let cell = tableView.dequeueReusableCell(withIdentifier: viewType.identifier, for: IndexPath(row: index, section: 0)) as? BaseTableViewCell else {
                    fatalError("Expect BaseTableViewCell")
                }
                _ = cell.configure(with: model)
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
            .modelSelected(DisplayedItemProtocol.self)
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
        // tableView
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.registerCellNib(EarthquakeListCell.self)
        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
    }
}
