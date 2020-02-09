//
//  Navigator.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit
import CoreLocation

protocol NavigatorProtocol {
    func show(segue: Navigator.Segue, sender: UIViewController)
}

struct Navigator: NavigatorProtocol {
    // MARK: - segues list
    enum Segue {
        case earthquakeList(GeonamesAPI.BoundingCoordinates, String)
        case earthquakeItem(CLLocationCoordinate2D)
    }
    // MARK: - invoke segue
    func show(segue: Navigator.Segue, sender: UIViewController) {
        switch segue {
        case .earthquakeList(let boundingCoordinates, let user):
            let viewModel = EarthquakeListViewModel(boundingCoordinates: boundingCoordinates, user: user)
            let target = EarthquakeListViewController.instantiate(fromAppStoryboard: .Main)
            target.viewModel = viewModel
            target.navigator = self
            show(target: target, sender: sender)
        case .earthquakeItem(let coordinate):
            break
        }
    }
    private func show(target: UIViewController, sender: UIViewController) {
      if let nc = sender as? UINavigationController {
        // push root controller on navigation stack
        nc.pushViewController(target, animated: false)
        return
      }
      if let nc = sender.navigationController {
        // add controller to navigation stack
        nc.pushViewController(target, animated: true)
      } else {
        // present modally
        sender.present(target, animated: true, completion: nil)
      }
    }
}
