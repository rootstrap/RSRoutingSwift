//
//  AppNavigator.swift
//  RSRoutingSwiftExample
//
//  Created by Tarek Radovan on 09/09/2022.
//

import Foundation
import RSRoutingSwift

final class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()
  
  private init() {
    let initialRoute: Route = AuthRoute.signIn
    super.init(with: initialRoute)
  }
  
  public required init(with route: Route) {
    super.init(with: route)
  }
}
