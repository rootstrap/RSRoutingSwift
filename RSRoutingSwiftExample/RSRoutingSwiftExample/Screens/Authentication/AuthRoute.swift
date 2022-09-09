//
//  AuthRoute.swift
//  RSRoutingSwiftExample
//
//  Created by Tarek Radovan on 09/09/2022.
//

import Foundation
import RSRoutingSwift
import UIKit

enum AuthRoute: Route {
  case signIn
  case signUp
  
  var screen: UIViewController {
    switch self {
    case .signIn:
      return SignInViewController()
    case .signUp:
      return SignUpViewController()
    }
  }
}
