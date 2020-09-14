//
//  Router.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

typealias EmptyClosure = (() -> Void)

class Router {
    private(set) var rootController: UINavigationController
    
    private var dismissCompletions: [UIViewController: EmptyClosure] = [:]
    private var popCompletions: [UIViewController: EmptyClosure] = [:]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, popCompletion: nil)
    }
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool = true,
                            pushCompletion: EmptyClosure? = nil,
                            popCompletion: EmptyClosure? = nil) {
        if let popCompletion = popCompletion {
            popCompletions[viewController] = popCompletion
        }
        
        rootController.pushViewController(viewController, animated: animated)
    }
    
    func presentViewController(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        presentViewController(viewController, dismissCompletion: nil)
    }
    
    func presentViewControllerAboveModal(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        rootController.presentedViewController?.present(viewController, animated: true)
    }
    
    func presentViewControllerAboveModalIfExists(_ animated: Bool = true, viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        if let presentedController = rootController.presentedViewController {
            presentedController.present(viewController, animated: animated)
        } else {
            rootController.present(viewController, animated: true)
        }
    }
    
    func presentViewController(_ viewController: UIViewController,
                               didShowedCompletion: EmptyClosure? = nil,
                               dismissCompletion: EmptyClosure?) {
        viewController.modalPresentationStyle = .fullScreen
        rootController.present(viewController, animated: true) { [weak self] in
            didShowedCompletion?()
            if let dismissCompletion = dismissCompletion {
                self?.dismissCompletions[viewController] = dismissCompletion
            }
        }
    }
    
    func dismiss(animated: Bool = true, completion: EmptyClosure? = nil) {
        rootController.viewControllers.compactMap { dismissCompletions[$0] }.forEach { $0() }
        rootController.dismiss(animated: animated, completion: completion)
    }
    
    func dismissAllModalIfExists(animated: Bool = true, completion: EmptyClosure? = nil) {
        if let presentedController = rootController.presentedViewController {
            dismissCompletions[presentedController]?()
            presentedController.dismiss(animated: animated, completion: completion)
        } else {
            completion?()
        }
    }
    
    func dismissFromModalIfExists(animated: Bool = true, completion: EmptyClosure? = nil) {
        if let presentedController = rootController.presentedViewController {
            presentedController.dismiss(animated: animated, completion: completion)
        } else {
            rootController.dismiss(animated: animated, completion: completion)
        }
    }
    
    func popViewController(animated: Bool = true, completion: EmptyClosure? = nil) {
        rootController.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool = true) {
        rootController.popToRootViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool = true) {
        rootController.popToViewController(viewController, animated: animated)
    }
    
    func setRootViewController(_ rootViewController: UIViewController?, animated: Bool = true) {
        guard let root = rootViewController else {
            rootController.setViewControllers([], animated: animated)
            return
        }
        
        rootController.setViewControllers([root], animated: animated)
    }
    
    func setNavBarHidden(_ isHidden: Bool) {
        rootController.isNavigationBarHidden = isHidden
    }
}
