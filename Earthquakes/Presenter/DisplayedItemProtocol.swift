//
//  DisplayedItemProtocol.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation

protocol DisplayedItemProtocol {
    var viewType: ConfigurableView.Type { get set }
}
