//
//  UIView+activityIndicator.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 08.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

extension UIView {
    func showActivityIndicator(_ color: UIColor? = nil) {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = color
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorView)
        self.bringSubviewToFront(indicatorView)
        // constraints
        do {
            var constraints: [NSLayoutConstraint] = []
            // center X
            constraints.append(indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
            // center Y
            constraints.append(indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
            constraints.forEach { $0.isActive = true }
        }
        indicatorView.startAnimating()
    }
    func hideActivityIndicator() {
        self.subviews
            .compactMap { $0 as? UIActivityIndicatorView }
            .forEachPerform { $0.stopAnimating() }
            .forEach { $0.removeFromSuperview() }
    }
}
