//
//  MainRoute.swift
//  RSRoutingSwiftExample
//
//  Created by Tarek Radovan on 09/09/2022.
//

import Foundation
import RSRoutingSwift
import UIKit

enum MainRoute: Route {
  case home
  
  var screen: UIViewController {
    switch self {
    case .home:
      return HomeViewController()
    }
  }
}
