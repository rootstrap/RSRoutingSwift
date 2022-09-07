//
//  TransitionType.swift
//  ios-routing
//
//  Created by Tarek Radovan on 07/09/2022.
//

import Foundation
import UIKit

// MARK: TransitionType
public enum TransitionType {
  case modal(style: UIModalPresentationStyle)
  case push
  case reset
  case changeRoot(
    transitionType: CATransitionType,
    transitionSubtype: CATransitionSubtype
  )
  
  static let changeRoot: TransitionType = .changeRoot(
    transitionType: .push,
    transitionSubtype: .fromTop
  )
}
