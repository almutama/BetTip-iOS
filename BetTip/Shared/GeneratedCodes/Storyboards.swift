// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

protocol StoryboardType {
  static var storyboardName: String { get }
}

extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

struct SceneType<T: Any> {
  let storyboard: StoryboardType.Type
  let identifier: String

  func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

struct InitialSceneType<T: Any> {
  let storyboard: StoryboardType.Type

  func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

protocol SegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
enum StoryboardScene {
  enum Admin: StoryboardType {
    static let storyboardName = "Admin"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Admin.self)
  }
  enum Basketball: StoryboardType {
    static let storyboardName = "Basketball"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Basketball.self)
  }
  enum Coupon: StoryboardType {
    static let storyboardName = "Coupon"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Coupon.self)
  }
  enum Credit: StoryboardType {
    static let storyboardName = "Credit"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Credit.self)
  }
  enum Football: StoryboardType {
    static let storyboardName = "Football"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Football.self)
  }
  enum LaunchScreen: StoryboardType {
    static let storyboardName = "LaunchScreen"

    static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  enum Login: StoryboardType {
    static let storyboardName = "Login"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: Login.self)
  }
  enum Main: StoryboardType {
    static let storyboardName = "Main"

    static let initialScene = InitialSceneType<BetTip.MainVC>(storyboard: Main.self)
  }
  enum Splash: StoryboardType {
    static let storyboardName = "Splash"

    static let initialScene = InitialSceneType<BetTip.SplashVC>(storyboard: Splash.self)
  }
  enum User: StoryboardType {
    static let storyboardName = "User"

    static let initialScene = InitialSceneType<UINavigationController>(storyboard: User.self)
  }
}

enum StoryboardSegue {
  enum Credit: String, SegueType {
    case buyCreditSegue
  }
  enum Login: String, SegueType {
    case forgorPasswordSegue
    case loginSegue
    case registerSegue
  }
  enum User: String, SegueType {
    case myCouponDetailSegue
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
