//
//  Router.swift
//  ios-routing
//
//  Created by Tarek Radovan on 07/09/2022.
//

import Foundation
import UIKit

// MARK: Route
public protocol Route {
  typealias TransitionConfigurator = (
    _ sourceVc: UIViewController?,
    _ destinationVc: UIViewController
  ) -> Void
  
  var screen: UIViewController { get }
  
  var transitionConfigurator: TransitionConfigurator? { get }
}

public extension Route {
  var transitionConfigurator: TransitionConfigurator? {
    nil
  }
}
