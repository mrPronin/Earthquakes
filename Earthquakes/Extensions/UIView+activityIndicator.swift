//
//  UIView+activityIndicator.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 08.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Public
    var activityIndicator: UIActivityIndicatorView {
        get {
            if let indicatorView = self.subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
                return indicatorView
            }
            return addActivityIndicator()
        }
        set {
            removeActivityIndicator()
            addSubview(newValue)
            autolayout(for: newValue)
        }
    }
    func addActivityIndicator(_ style: UIActivityIndicatorView.Style? = .medium, color: UIColor? = nil) -> UIActivityIndicatorView {
        if let indicatorView = self.subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
            if let color = color {
                indicatorView.color = color
            }
            if let style = style {
                indicatorView.style = style
            }
            return indicatorView
        }
        let indicatorView = UIActivityIndicatorView(style: style ?? .medium)
        indicatorView.color = color
        addSubview(indicatorView)
        autolayout(for: indicatorView)
        return indicatorView
    }
    // MARK: - Private
    private func autolayout(for indicatorView: UIActivityIndicatorView) {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
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
    }
    private func removeActivityIndicator() {
        self.subviews
            .compactMap { $0 as? UIActivityIndicatorView }
            .forEachPerform { $0.stopAnimating() }
            .forEach { $0.removeFromSuperview() }
    }
}
