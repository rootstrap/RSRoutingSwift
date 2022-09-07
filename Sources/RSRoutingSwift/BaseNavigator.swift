//
//  BaseNavigator.swift
//  ios-routing
//
//  Created by Tarek Radovan on 07/09/2022.
//

import Foundation
import UIKit

open class BaseNavigator: Navigator {
  public var navigationController: UINavigationController?
  public var currentViewController: UIViewController? {
    navigationController?.visibleViewController ?? navigationController?.topViewController
  }

  public required init(with route: Route) {
    navigationController = route.screen.embedInNavigationController()
  }
}

extension UIViewController {
  func embedInNavigationController() -> UINavigationController {
    if let navigation = self as? UINavigationController {
      return navigation
    }
    let navigationController = UINavigationController(rootViewController: self)
    navigationController.isNavigationBarHidden = true
    return navigationController
  }
}
