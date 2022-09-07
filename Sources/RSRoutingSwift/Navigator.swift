//
//  Navigator.swift
//  ios-routing
//
//  Created by Tarek Radovan on 07/09/2022.
//

import Foundation
import UIKit

// MARK: Navigator
public protocol Navigator: AnyObject {
  
  var navigationController: UINavigationController? { get set }
  var currentViewController: UIViewController? { get }
  
  init(with route: Route)
  
  func navigate(
    toRoute route: Route,
    withTransition transition: TransitionType,
    animated: Bool,
    completion: (() -> Void)?
  )
  
  func navigate(
    toRouter router: Navigator,
    animated: Bool,
    completion: (() -> Void)?
  )
  
  func popToRoot(animated: Bool)
  
  func pop(animated: Bool)
  
  func popto(index: Int, animated: Bool)
  
  func popTo(route: Route, animated: Bool)
  
  func dismiss(animated: Bool, completion: (() -> Void)?)
}

public extension Navigator {
  func navigate(
    toRoute route: Route,
    withTransition transition: TransitionType,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    let viewController = route.screen
    
    switch transition {
    case .modal(let style):
      route.transitionConfigurator?(currentViewController, viewController)
      navigationController?.modalPresentationStyle = style
      navigationController?.present(
        viewController,
        animated: true,
        completion: completion
      )
    case .push:
      route.transitionConfigurator?(currentViewController, viewController)
      navigationController?.pushViewController(viewController, animated: animated)
    case .reset:
      route.transitionConfigurator?(nil, viewController)
      navigationController?.setViewControllers([viewController], animated: animated)
    case .changeRoot(let transitionType, let transitionSubtype):
      let navigationController = viewController.embedInNavigationController()
      self.navigationController = navigationController
      animateRootReplacementTransition(
        toController: navigationController,
        withTransitionType: transitionType,
        andTransitionSubtype: transitionSubtype
      )
    }
  }
  
  func navigate(
    toRouter router: Navigator,
    animated: Bool,
    completion: (() -> Void)?
  ) {
    guard let navigationController = router.navigationController else {
      assert(false, "Navigator does not have a root view controller")
      return
    }
    
    currentViewController?.present(
      navigationController,
      animated: animated,
      completion: completion
    )
  }
  
  func pop(animated: Bool) {
    navigationController?.popViewController(animated: animated)
  }
  
  func popto(index: Int, animated: Bool) {
    guard
      let viewControllers = navigationController?.viewControllers,
      viewControllers.count > index else {
        return
      }
    let viewController = viewControllers[index]
    navigationController?.popToViewController(viewController, animated: animated)
  }
  
  func popToRoot(animated: Bool = true) {
    navigationController?.popToRootViewController(animated: animated)
  }

  func popTo(route: Route, animated: Bool) {
    guard
      let viewControllers = navigationController?.viewControllers,
      let viewController = viewControllers.first(where: {
        type(of: $0) == type(of: route.screen)
      })
    else { return }
    navigationController?.popToViewController(viewController, animated: animated)
  }
  
  func dismiss(animated: Bool, completion: (() -> Void)?) {
    currentViewController?.dismiss(animated: animated, completion: completion)
  }
  
  private func animateRootReplacementTransition(
    toController viewController: UIViewController,
    withTransitionType type: CATransitionType,
    andTransitionSubtype subtype: CATransitionSubtype
  ) {
    let window = UIApplication.shared.keyWindow
    let transition = CATransition()
    transition.duration = 0.3
    transition.timingFunction = CAMediaTimingFunction(
      name: CAMediaTimingFunctionName.easeOut
    )
    transition.type = type
    transition.subtype = subtype
    window?.layer.add(transition, forKey: kCATransition)
  
    window?.rootViewController = viewController
  }
}
