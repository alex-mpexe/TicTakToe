//
//  Router.swift
//  TicTakToe
//
//  Created by Alexey on 12.07.2021.
//

import UIKit

protocol Router {
    
    var storyboard: UIStoryboard { get }
    var presenter: UIViewController? { get }
    
    init(presenter: UIViewController?)
    
}

extension Router {
    
    func show(_ viewController: UIViewController, animationType: UIView.AnimationOptions = .transitionCrossDissolve, needEndEditing: Bool = true) {
        guard let presenter = presenter else {
            UIWindow.keyWindowTransitToViewController(viewController, animationType: animationType)
            return
        }
        if needEndEditing {
            presenter.firstParent().view.endEditing(true)
        }
        presenter.show(viewController, sender: .none)
    }
    
    func set(_ viewController: UIViewController, animated: Bool = true, animationType: UIView.AnimationOptions = .transitionCrossDissolve) {
        if let navVC = presenter?.navigationController {
            presenter?.firstParent().view.endEditing(true)
            navVC.pushViewController(viewController, animated: animated)
        } else {
            show(viewController, animationType: animationType)
        }
    }
    
    func setRoot(_ viewController: UIViewController, animated: Bool = true, animationType: UIView.AnimationOptions = .transitionCrossDissolve) {
        if let navVC = presenter?.navigationController {
            presenter?.firstParent().view.endEditing(true)
            navVC.setViewControllers([viewController], animated: animated)
        } else {
            show(viewController, animationType: animationType)
        }
    }
    
    func setToRoot(animated: Bool = true, animationType: UIView.AnimationOptions = .transitionCrossDissolve) {
        if let navVC = presenter?.navigationController {
            navVC.popToRootViewController(animated: animated)
        }
    }
    
    func presentModal(_ viewController: UIViewController,
                      animated: Bool = true,
                      animationType: UIView.AnimationOptions = .transitionCrossDissolve,
                      completion: (() -> ())? = .none) {
        guard let presenter = presenter else {
            UIWindow.keyWindowTransitToViewController(viewController, animationType: animationType)
            return
        }
        presenter.present(viewController,
                          animated: animated,
                          completion: completion)
    }
    
    func presentChild(_ viewController: UIViewController, inViewController vc: UIViewController) {
        vc.addChild(viewController)
        viewController.willMove(toParent: vc)
        vc.view.addSubview(viewController.view)
        viewController.didMove(toParent: vc)
    }
    
}

extension UIViewController {
    func firstParent() -> UIViewController {
        if let parent = self.parent {
            return parent.firstParent()
        } else {
            return self
        }
    }
}

public extension UIWindow {
    
    class func keyWindowTransitToViewController(_ viewController: UIViewController, animationType: UIView.AnimationOptions) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func transitToViewController(_ viewController: UIViewController, animationType: UIView.AnimationOptions) {
        let previousViewController = rootViewController
        
        let currentSubviews = subviews
        insertSubview(viewController.view, belowSubview: rootViewController!.view)
        UIView.transition(with: self,
                          duration: 0.3,
                          options: animationType,
                          animations: { self.rootViewController = viewController },
                          completion: { _ in
                            currentSubviews.forEach({
                                if !($0 is UIImageView) {
                                    $0.removeFromSuperview()
                                }
                            })
                            
                            if let previousViewController = previousViewController {
                                // Allow the view controller to be deallocated
                                previousViewController.dismiss(animated: false) {
                                    // Remove the root view in case its still showing
                                    previousViewController.view.removeFromSuperview()
                                }
                            }
        })
    }
    
}
