// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Auth {
    /// Do you want to log out?
    static let confirmLogout = L10n.tr("Localizable", "Auth.ConfirmLogout")
    /// Email
    static let email = L10n.tr("Localizable", "Auth.Email")
    /// Log in
    static let login = L10n.tr("Localizable", "Auth.Login")
    /// Log out
    static let logout = L10n.tr("Localizable", "Auth.Logout")
    /// Password
    static let password = L10n.tr("Localizable", "Auth.Password")
    /// Sign up
    static let signUp = L10n.tr("Localizable", "Auth.SignUp")

    enum Error {
      /// Email already registered.
      static let emailAlreadyInUse = L10n.tr("Localizable", "Auth.Error.EmailAlreadyInUse")
      /// Email can't be empty.
      static let emptyEmail = L10n.tr("Localizable", "Auth.Error.EmptyEmail")
      /// Password can't be empty.
      static let emptyPassword = L10n.tr("Localizable", "Auth.Error.EmptyPassword")
      /// Email is not valid.
      static let invalidEmail = L10n.tr("Localizable", "Auth.Error.InvalidEmail")
      /// Can't log in
      static let loginTitle = L10n.tr("Localizable", "Auth.Error.LoginTitle")
      /// Password has to be at least %d characters long.
      static func shortPassword(_ p1: Int) -> String {
        return L10n.tr("Localizable", "Auth.Error.ShortPassword", p1)
      }
      /// Can't register
      static let signupTitle = L10n.tr("Localizable", "Auth.Error.SignupTitle")
      /// An internal error occured. Please try again later.
      static let unknown = L10n.tr("Localizable", "Auth.Error.Unknown")
      /// Your account has been disabled. Please contact us if you think this is a mistake.
      static let userDisabled = L10n.tr("Localizable", "Auth.Error.UserDisabled")
      /// You've entered a wrong email or password.
      static let wrongPassword = L10n.tr("Localizable", "Auth.Error.WrongPassword")
    }
  }

  enum Common {
    /// Cancel
    static let cancel = L10n.tr("Localizable", "Common.Cancel")
    /// Done
    static let done = L10n.tr("Localizable", "Common.Done")
    /// Error Occured
    static let error = L10n.tr("Localizable", "Common.Error")
    /// Great
    static let great = L10n.tr("Localizable", "Common.Great")
    /// Loading ..
    static let loading = L10n.tr("Localizable", "Common.Loading")
    /// OK
    static let ok = L10n.tr("Localizable", "Common.OK")
    /// Please try again later.
    static let tryAgainLater = L10n.tr("Localizable", "Common.TryAgainLater")
  }

  enum Credit {
    /// Set requiremnt fields.
    static let addCredit = L10n.tr("Localizable", "Credit.AddCredit")
    /// Can't add a new credit!
    static let addError = L10n.tr("Localizable", "Credit.AddError")
    /// Added a new credit!
    static let addSuccess = L10n.tr("Localizable", "Credit.AddSuccess")
    /// Number of Credits
    static let numberOfCredit = L10n.tr("Localizable", "Credit.NumberOfCredit")
    /// Price
    static let price = L10n.tr("Localizable", "Credit.Price")
    /// Credit
    static let title = L10n.tr("Localizable", "Credit.Title")
  }

  enum Role {
    /// Administrator
    static let admin = L10n.tr("Localizable", "Role.Admin")
    /// Moderator
    static let moderator = L10n.tr("Localizable", "Role.Moderator")
    /// User
    static let user = L10n.tr("Localizable", "Role.User")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
