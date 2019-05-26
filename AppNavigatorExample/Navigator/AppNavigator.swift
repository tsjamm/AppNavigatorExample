//
//  AppNavigator.swift
//  AppNavigatorExample
//
//  Created by Sai Teja on 5/26/19.
//  Copyright © 2019 Sai Teja. All rights reserved.
//

import UIKit

fileprivate protocol NavigatorDestination {
    associatedtype PresentationStyle
    static var `default`: Self { get }
    var presentationStyle: PresentationStyle { get }
    var viewController: UIViewController { get }
}

fileprivate protocol Navigator {
    associatedtype Destination: NavigatorDestination
    associatedtype PresentationStyle
    func navigate(to destination: Destination,
                  with presentationStyle: PresentationStyle?,
                  animated: Bool) -> UIViewController?
    func navigate(basedOn url: URL,
                  with presentationStyle: PresentationStyle?,
                  animated: Bool) -> UIViewController?
}

class AppNavigator: Navigator {
    
    enum PresentationStyle {
        case present(withNewNavigationController: Bool)
        case push
        case replace
        case rootReplace
    }
    
    enum Destination: String, NavigatorDestination {
        
        case login
        case home
        case profile
        case news
        
        static var `default`: Destination {
            return login
        }
        
        var presentationStyle: PresentationStyle {
            switch self {
            case .login:
                return .rootReplace
            case .home:
                return .replace
            case .profile:
                return .push
            case .news:
                return .present(withNewNavigationController: true)
            }
        }
        
        var viewController: UIViewController {
            switch self {
            case .login:
                return LoginViewController()
            case .home:
                return HomeViewController()
            case .profile:
                return ProfileViewController()
            case .news:
                return NewsViewController()
            }
        }
    }
    
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func navigate(to destination: Destination,
                  with presentationStyle: PresentationStyle? = nil,
                  animated: Bool = true) -> UIViewController? {
        let destinationViewController = destination.viewController
        switch (presentationStyle ?? destination.presentationStyle) {
        case .present(let withNewNavigationController):
            if withNewNavigationController {
                let navigationController = UINavigationController(rootViewController: destinationViewController)
                self.navigationController?.present(navigationController, animated: animated, completion: nil)
            } else {
                self.navigationController?.present(destinationViewController, animated: animated, completion: nil)
            }
        case .push:
            navigationController?.pushViewController(destinationViewController, animated: animated)
        case .replace:
            navigationController?.setViewControllers([destinationViewController], animated: animated)
        case .rootReplace:
            if let rootWindow = UIApplication.shared.delegate?.window {
                rootWindow?.rootViewController?.dismiss(animated: false, completion: {
                    if let rootNavigationVC = rootWindow?.rootViewController as? UINavigationController {
                        rootNavigationVC.setViewControllers([destinationViewController], animated: animated)
                    } else {
                        rootWindow?.rootViewController = UINavigationController(rootViewController: destinationViewController)
                    }
                })
            }
        }
        return destinationViewController
    }
    
    @discardableResult
    func navigate(basedOn url: URL,
                  with presentationStyle: PresentationStyle? = nil,
                  animated: Bool = true) -> UIViewController? {
        guard url.scheme == "AppNavigatorExample",
            let host = url.host,
            let destination = Destination(rawValue: host) else {
                return nil
        }
        return navigate(to: destination, with: presentationStyle, animated: animated)
    }
    
    static func initialize(with appDelegate: UIApplicationDelegate) {
        let defaultViewController = Destination.default.viewController
        appDelegate.window??.rootViewController = UINavigationController(rootViewController: defaultViewController)
    }
    
    static func navigate(basedOn url: URL, with appDelegate: UIApplicationDelegate) {
        if let navigationController = appDelegate.window??.rootViewController as? UINavigationController {
            let appNavigator = AppNavigator(with: navigationController)
            appNavigator.navigate(basedOn: url)
        }
    }
}
