# RSRoutingSwift

**RSRoutingSwift** is a practical Swift framework that aims to ease the routing and navigation of your app.

The overall design is based on UIKit's `UINavigationController`, so integrating it should be straight forward.

## How to use it?

- Route: It represents a destination screen in your application.
The `screen` property returns the `UIViewController` object to navigate to. 
Here is an example of how your custom routes could conform to the protocol:

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
      return MyProfileViewController()
    case .settings:
      return UIStoryboard.settings.instantiateInitialViewController()
    }
  }
}

```
- BaseNavigator: It's a handy concrete implementation of the `Navigator` protocol. 
It uses a `UINavigationController` as its `rootViewController` to handle navigation between routes. 
In the example app, `AppNavigator` demonstrates how to extend the `BaseNavigator` behavior to decide which is going be the initial route during initialization.

```swift
final class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()

  private init() {
    let initialRoute: Route = SessionDataManager.isValidSession 
      ? MainRoute.home
      : AuthRoute.signIn
    super.init(with: initialRoute)
  }

  public required init(with route: Route) {
    super.init(with: route)
  }
}
```

Then we can use the `AppNavigator` to navigate between screens like:

_Classic push presentation into the navigation stack._
```swift
  func signUpButtonWasPressed() {
    AppNavigator.shared.navigate(
      toRoute: AuthRoute.signUp,
      withTransition: .push
    )
  }
```

_Custom transition that swaps the root controller with the destination Route._
```swift
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

## Installation

_`TODO`_

## License

_`TODO`_

## Credits

**RSRoutingSwift** is maintained by [Rootstrap](http://www.rootstrap.com) with the help of our [contributors](https://github.com/rootstrap/ios-base/contributors).

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)