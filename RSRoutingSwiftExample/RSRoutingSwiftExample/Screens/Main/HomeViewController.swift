//
//  HomeViewController.swift
//  RSRoutingSwiftExample
//
//  Created by Tarek Radovan on 09/09/2022.
//

import UIKit

final class HomeViewController: UIViewController {

  private let buttonHeight: CGFloat = 50
  
  private lazy var logOutButton: UIButton = {
    let button = UIButton()
    button.setTitle("Log Out", for: [])
    button.setTitleColor(.white, for: [])
    button.backgroundColor = .systemGray
    button.layer.cornerRadius = buttonHeight / 2
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(
      self,
      action: #selector(logOutButtonWasPressed),
      for: .touchUpInside
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()

  }
}

// MARK: Private
private extension HomeViewController {
  
  func configureViews() {
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Home"
    addViews()
    setConstraints()
    setStyles()
  }
  
  func addViews() {
    view.addSubview(logOutButton)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logOutButton.heightAnchor.constraint(equalToConstant: buttonHeight),
      logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
    ])
  }
  
  func setStyles() {
    view.backgroundColor = .homeBackground
  }
  
  @objc
  func logOutButtonWasPressed() {
    AppNavigator.shared.navigate(
      toRoute: AuthRoute.signIn,
      withTransition: .changeRoot(
        transitionType: .fade,
        transitionSubtype: .fromBottom
      )
    )
  }
}
