//
//  String+className.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
