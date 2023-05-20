//
//  ToldUIViewControllerExtension.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 28/04/2023.
//

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

        var viewControllerName = NSStringFromClass(type(of: self))
        viewControllerName = viewControllerName.replacingOccurrences(of: "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String ?? "").", with: "")
        
        Told.currentViewController = self
        Told.currentViewControllerName = viewControllerName
    }

}
