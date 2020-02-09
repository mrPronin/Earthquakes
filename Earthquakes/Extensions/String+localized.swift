//
//  String+localized.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
