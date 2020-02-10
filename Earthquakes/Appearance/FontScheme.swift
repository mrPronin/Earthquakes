//
//  FontScheme.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

enum FontSize: Int {
    case h1 = 26
    case h2 = 24
    case h3 = 20
    case h4 = 18
    case h5 = 16
    case h6 = 14
    case h7 = 12
    case h8 = 10
    case h9 = 8
}

enum BrandFont {
    case regular
    case italic
    case ultraLight
    case thin
    case light
    case medium
    case bold
    case semiBold
}

extension UIFont {
    static func brand(font style: BrandFont, withCustomSize size: CGFloat) -> UIFont {
        switch style {
        case .regular:          return UIFont.systemFont(ofSize: size)
        case .italic:           return UIFont.italicSystemFont(ofSize: size)
        case .ultraLight:       return UIFont.systemFont(ofSize: size, weight: .ultraLight)
        case .thin:             return UIFont.systemFont(ofSize: size, weight: .thin)
        case .light:            return UIFont.systemFont(ofSize: size, weight: .light)
        case .medium:           return UIFont.systemFont(ofSize: size, weight: .medium)
        case .bold:             return UIFont.boldSystemFont(ofSize: size)
        case .semiBold:         return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
    }
    static func brand(font: BrandFont, withSize size: FontSize) -> UIFont {
        return brand(font: font, withCustomSize: CGFloat(size.rawValue))
    }
}
