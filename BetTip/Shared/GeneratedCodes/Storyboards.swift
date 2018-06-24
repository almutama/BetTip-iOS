// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Admin: StoryboardType {
    internal static let storyboardName = "Admin"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Admin.self)
  }
  internal enum Basketball: StoryboardType {
    internal static let storyboardName = "Basketball"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Basketball.self)
  }
  internal enum Coupon: StoryboardType {
    internal static let storyboardName = "Coupon"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Coupon.self)
  }
  internal enum Credit: StoryboardType {
    internal static let storyboardName = "Credit"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Credit.self)
  }
  internal enum Football: StoryboardType {
    internal static let storyboardName = "Football"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Football.self)
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Login: StoryboardType {
    internal static let storyboardName = "Login"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Login.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<BetTip.MainVC>(storyboard: Main.self)
  }
  internal enum Splash: StoryboardType {
    internal static let storyboardName = "Splash"

    internal static let initialScene = InitialSceneType<BetTip.SplashVC>(storyboard: Splash.self)
  }
  internal enum User: StoryboardType {
    internal static let storyboardName = "User"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: User.self)
  }
}

internal enum StoryboardSegue {
  internal enum Admin: String, SegueType {
    case adminCouponDetailSegue
  }
  internal enum Coupon: String, SegueType {
    case couponDetailSegue
  }
  internal enum Credit: String, SegueType {
    case buyCreditSegue
  }
  internal enum Login: String, SegueType {
    case forgorPasswordSegue
    case loginSegue
    case registerSegue
  }
  internal enum User: String, SegueType {
    case myCouponDetailSegue
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
