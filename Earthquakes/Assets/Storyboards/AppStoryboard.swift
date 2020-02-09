//
//  AppStoryboard.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 09.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

public enum AppStoryboard: String {
    case Main
    fileprivate var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    fileprivate func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        let storyboard = self.instance
        guard let scene = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
}

public extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    fileprivate class var storyboardID: String { return "\(self)" }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
