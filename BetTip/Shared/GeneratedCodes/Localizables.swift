// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Applepay {
    /// Please set up Apple-Pay!
    static let setAccount = L10n.tr("Localizable", "ApplePay.SetAccount")
  }

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
    /// Delete
    static let delete = L10n.tr("Localizable", "Common.Delete")
    /// Done
    static let done = L10n.tr("Localizable", "Common.Done")
    /// Error Occured
    static let error = L10n.tr("Localizable", "Common.Error")
    /// Great ☺️
    static let great = L10n.tr("Localizable", "Common.Great")
    /// Loading ..
    static let loading = L10n.tr("Localizable", "Common.Loading")
    /// OK
    static let ok = L10n.tr("Localizable", "Common.OK")
    /// Sorry 😢
    static let sorry = L10n.tr("Localizable", "Common.Sorry")
    /// Success
    static let success = L10n.tr("Localizable", "Common.Success")
    /// Are you sure?
    static let sure = L10n.tr("Localizable", "Common.Sure")
    /// Please try again later.
    static let tryAgainLater = L10n.tr("Localizable", "Common.TryAgainLater")
    /// Update
    static let update = L10n.tr("Localizable", "Common.Update")
    /// Warning
    static let warning = L10n.tr("Localizable", "Common.Warning")

    enum Process {
      /// Process couldn't be finished.
      static let error = L10n.tr("Localizable", "Common.Process.Error")
      /// Process has been finished successfully.
      static let success = L10n.tr("Localizable", "Common.Process.Success")
    }
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
    /// Update requiremnt fields.
    static let updateCredit = L10n.tr("Localizable", "Credit.UpdateCredit")
  }

  enum Match {
    /// Basketball
    static let basketball = L10n.tr("Localizable", "Match.Basketball")
    /// Football
    static let football = L10n.tr("Localizable", "Match.Football")
  }

  enum Role {
    /// Administrator
    static let admin = L10n.tr("Localizable", "Role.Admin")
    /// Moderator
    static let moderator = L10n.tr("Localizable", "Role.Moderator")
    /// User
    static let user = L10n.tr("Localizable", "Role.User")
  }

  enum User {

    enum Action {
      /// Please select an action.
      static let desc = L10n.tr("Localizable", "User.Action.Desc")
      /// User Actions
      static let title = L10n.tr("Localizable", "User.Action.Title")
    }

    enum Role {
      /// Admin
      static let admin = L10n.tr("Localizable", "User.Role.Admin")
      /// Change User's Role
      static let changeRole = L10n.tr("Localizable", "User.Role.ChangeRole")
      /// Disable User
      static let disable = L10n.tr("Localizable", "User.Role.Disable")
      /// Enable User
      static let enable = L10n.tr("Localizable", "User.Role.Enable")
      /// Moderator
      static let moderator = L10n.tr("Localizable", "User.Role.Moderator")
      /// User Role
      static let title = L10n.tr("Localizable", "User.Role.Title")
      /// User
      static let user = L10n.tr("Localizable", "User.Role.User")
    }
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
