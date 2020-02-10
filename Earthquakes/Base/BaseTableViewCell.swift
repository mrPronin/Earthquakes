//
//  BaseTableViewCell.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ConfigurableView {
    // MARK: - Public
    class var identifier: String { return String.className(self) }
    class func height() -> CGFloat { 0 }
    // MARK: - ConfigurableView
    func configure(with viewModel: DisplayedItemProtocol) -> ConfigurableView {
        fatalError("Should be overridden in superclasses")
    }
}
