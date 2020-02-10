//
//  UIImageView+imageColor.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

extension UIImageView {
    var imageColor: UIColor? {
        get {
            return self.tintColor
        }
        set {
            let origImage = self.image
            let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.image = tintedImage
            self.tintColor = newValue
        }
    }
}
