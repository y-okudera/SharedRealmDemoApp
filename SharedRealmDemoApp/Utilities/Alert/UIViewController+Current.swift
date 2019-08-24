//
//  UIViewController+Current.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/12.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

extension UIViewController {

    /// 現在表示中のViewControllerを取得する
    static var current: UIViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrent(controller: rootViewController)
        }
        return nil
    }
}

private extension UIViewController {

    static func findCurrent(controller: UIViewController) -> UIViewController {
        if let presentedViewController = controller.presentedViewController {
            return findCurrent(controller: presentedViewController)
        }
        if let splitViewController = controller as? UISplitViewController, let first = splitViewController.findFirst() {
            return findCurrent(controller: first)
        }
        if let navigationController = controller as? UINavigationController, let top = navigationController.findTop() {
            return findCurrent(controller: top)
        }
        if let tabBarController = controller as? UITabBarController, let selected = tabBarController.findSelected() {
            return findCurrent(controller: selected)
        }
        return controller
    }
}

private extension UISplitViewController {
    func findFirst() -> UIViewController? {
        if let first = viewControllers.first, viewControllers.count > 0 {
            return first
        }
        return nil
    }
}

private extension UINavigationController {
    func findTop() -> UIViewController? {
        if let top = topViewController, viewControllers.count > 0 {
            return top
        }
        return nil
    }
}

private extension UITabBarController {
    func findSelected() -> UIViewController? {
        if let selected = selectedViewController, (viewControllers?.count ?? 0) > 0 {
            return selected
        }
        return nil
    }
}
