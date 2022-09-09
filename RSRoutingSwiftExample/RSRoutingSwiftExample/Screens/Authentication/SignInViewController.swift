//
//  SignInViewController.swift
//  RSRoutingSwiftExample
//
//  Created by Tarek Radovan on 09/09/2022.
//

import UIKit

final class SignInViewController: UIViewController {
  
  private let buttonHeight: CGFloat = 50
  
  private lazy var signUpButton: UIButton = {
    let button = UIButton()
    button.setTitle("Sign Up", for: [])
    button.setTitleColor(.systemBlue, for: [])
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(
      self,
      action: #selector(signUpButtonWasPressed),
      for: .touchUpInside
    )
    return button
  }()
  
  private lazy var signInButton: UIButton = {
    let button = UIButton()
    button.setTitle("Sign In", for: [])
    button.setTitleColor(.white, for: [])
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = buttonHeight / 2
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(
      self,
      action: #selector(signInButtonWasPressed),
      for: .touchUpInside
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
  }
}

//MARK: Private
private extension SignInViewController {
  
  @objc
  func signUpButtonWasPressed() {
    AppNavigator.shared.navigate(
      toRoute: AuthRoute.signUp,
      withTransition: .push
    )
  }
  @objc
  func signInButtonWasPressed() {
    AppNavigator.shared.navigate(
      toRoute: MainRoute.home,
      withTransition: .changeRoot(
        transitionType: .fade,
        transitionSubtype: .fromBottom
      )
    )
  }
  
  func configureViews() {
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Sign In"
    addViews()
    setConstraints()
    setStyles()
  }
  
  func addViews() {
    view.addSubview(signInButton)
    view.addSubview(signUpButton)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.heightAnchor.constraint(equalToConstant: buttonHeight),
      
      signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -10),
      signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signInButton.heightAnchor.constraint(equalToConstant: buttonHeight),
      signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
    ])
  }
  
  func setStyles() {
    view.backgroundColor = .authBackground
  }
}
