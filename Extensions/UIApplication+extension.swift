//
//  UIApplication+extension.swift
//  ios-routing
//
//  Created by Tarek Radovan on 07/09/2022.
//

import Foundation
import UIKit

/// Get connected scenes
/// 1. Keep only active scenes, onscreen and visible to the user
/// 2. Keep only the first `UIWindowScene`
/// 3. Get its associated windows
/// 4. Finally, keep only the key window
extension UIApplication {
  var keyWindow: UIWindow? {
    return connectedScenes
      .filter { $0.activationState == .foregroundActive } /// 1
      .first(where: { $0 is UIWindowScene }) /// 2
      .flatMap({ $0 as? UIWindowScene })?.windows /// 3
      .first(where: \.isKeyWindow) /// 4
  }
}
