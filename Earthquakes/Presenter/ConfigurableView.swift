//
//  ConfigurableView.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

protocol ConfigurableView: UIView {
    func configure(with viewModel: DisplayedItemProtocol) -> ConfigurableView
}
