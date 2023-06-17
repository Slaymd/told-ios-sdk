//
//  ToldUIViewControllerExtension.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 28/04/2023.
//

import UIKit

extension UIViewController {

    static let swizzleMethod: Void = {
        let originalSelector = #selector(viewDidAppear(_:))
        let swizzledSelector = #selector(swizzled_viewDidAppear(_:))
        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }()

    @objc func swizzled_viewDidAppear(_ animated: Bool) {
        swizzled_viewDidAppear(animated)

        let bundleExecutableName = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String

        var viewControllerName = NSStringFromClass(type(of: self))

        if (!viewControllerName.starts(with: "\(bundleExecutableName ?? "").")) { return }

        viewControllerName = viewControllerName.replacingOccurrences(of: "\(bundleExecutableName ?? "").", with: "")

        Told.currentViewController = self
        Told.currentViewControllerName = viewControllerName
    }
    
    internal static func swizzleViewDidAppear() {
        swizzleMethod
    }

}
