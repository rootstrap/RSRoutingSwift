# RSRoutingSwift
iOS RSRoutingSwift

RSRoutingSwift is a practical spm that will make it easier for you to manage routes and navigate through the app.

All the internal classes and code is native in swift and `UINavigationController` based 

# How To use it?

- Route: It Represents the connection between two screens or viewControllers.
`screen` variable give us the destination viewController or where we need to go, you can implement it like this:

```swift
enum MainRoute: Route {
  case home
  case profile
  case settings

  var screen: UIViewController {
    switch self {
    case .home:
      return buildHomeViewController()
    case .profile:
      return buildProfileViewCOntroller()
    case .settings:
      return buildSettingsViewController()
    }
  }
}

enum AuthRoute: Route {
  case signIn
  case signUp

  var screen: UIViewController {
    switch self {
    case .signIn:
      return buildSignInViewController()
    case .signUp:
      return buildSignUpViewController()
    }
  }
}
```
- BaseNavigator: It's the navigation class (implements the `Navigator protocol`), require an initial `route` or `root viewController` and it'll be used it to go from one screen to another or to navigate between routes. AppNavigator is our example class, this one inherit from `BaseNavigator` and as you can see, we can decide which gonna be the initial route before initialize the `BaseNavigator`

```swift
final class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()

  private init() {
    let initialRoute: Route = SessionDataManager.isValidSession ?
      MainRoute.home : AuthRoute.signIn
    super.init(with: initialRoute)
  }

  public required init(with route: Route) {
    super.init(with: route)
  }
}
```

Then we can call the AppNavigator to navigate between screens ie:

```swift
  @objc
  func signUpButtonWasPressed() {
    AppNavigator.shared.navigate(
      toRoute: AuthRoute.signUp,
      withTransition: .push
    )
  }
```

Or we can change the whole route for another new. ie:

```swift
  @objc
  func signInButtonWasPressed() {
    /// validate credentials first and then...
    AppNavigator.shared.navigate(
      toRoute: MainRoute.home,
      withTransition: .changeRoot(
        transitionType: .fade,
        transitionSubtype: .fromBottom
      )
    )
  }
```

