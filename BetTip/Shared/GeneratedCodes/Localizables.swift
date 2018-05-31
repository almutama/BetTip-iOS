// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Applepay {
    /// Please set up Apple-Pay!
    internal static let setAccount = L10n.tr("Localizable", "ApplePay.SetAccount")
  }

  internal enum Auth {
    /// Do you want to log out?
    internal static let confirmLogout = L10n.tr("Localizable", "Auth.ConfirmLogout")
    /// Email
    internal static let email = L10n.tr("Localizable", "Auth.Email")
    /// Log in
    internal static let login = L10n.tr("Localizable", "Auth.Login")
    /// Log out
    internal static let logout = L10n.tr("Localizable", "Auth.Logout")
    /// Password
    internal static let password = L10n.tr("Localizable", "Auth.Password")
    /// Sign up
    internal static let signUp = L10n.tr("Localizable", "Auth.SignUp")

    internal enum Error {
      /// Email already registered.
      internal static let emailAlreadyInUse = L10n.tr("Localizable", "Auth.Error.EmailAlreadyInUse")
      /// Email can't be empty.
      internal static let emptyEmail = L10n.tr("Localizable", "Auth.Error.EmptyEmail")
      /// Password can't be empty.
      internal static let emptyPassword = L10n.tr("Localizable", "Auth.Error.EmptyPassword")
      /// Email is not valid.
      internal static let invalidEmail = L10n.tr("Localizable", "Auth.Error.InvalidEmail")
      /// Can't log in
      internal static let loginTitle = L10n.tr("Localizable", "Auth.Error.LoginTitle")
      /// Password has to be at least %d characters long.
      internal static func shortPassword(_ p1: Int) -> String {
        return L10n.tr("Localizable", "Auth.Error.ShortPassword", p1)
      }
      /// Can't register
      internal static let signupTitle = L10n.tr("Localizable", "Auth.Error.SignupTitle")
      /// An internal error occured. Please try again later.
      internal static let unknown = L10n.tr("Localizable", "Auth.Error.Unknown")
      /// Your account has been disabled. Please contact us if you think this is a mistake.
      internal static let userDisabled = L10n.tr("Localizable", "Auth.Error.UserDisabled")
      /// You've entered a wrong email or password.
      internal static let wrongPassword = L10n.tr("Localizable", "Auth.Error.WrongPassword")
    }
  }

  internal enum Common {
    /// Buy
    internal static let buy = L10n.tr("Localizable", "Common.Buy")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Common.Cancel")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "Common.Delete")
    /// Done
    internal static let done = L10n.tr("Localizable", "Common.Done")
    /// Error Occured
    internal static let error = L10n.tr("Localizable", "Common.Error")
    /// Great ☺️
    internal static let great = L10n.tr("Localizable", "Common.Great")
    /// Loading ..
    internal static let loading = L10n.tr("Localizable", "Common.Loading")
    /// OK
    internal static let ok = L10n.tr("Localizable", "Common.OK")
    /// Sorry 😢
    internal static let sorry = L10n.tr("Localizable", "Common.Sorry")
    /// Success
    internal static let success = L10n.tr("Localizable", "Common.Success")
    /// Are you sure?
    internal static let sure = L10n.tr("Localizable", "Common.Sure")
    /// Please try again later.
    internal static let tryAgainLater = L10n.tr("Localizable", "Common.TryAgainLater")
    /// Update
    internal static let update = L10n.tr("Localizable", "Common.Update")
    /// Warning
    internal static let warning = L10n.tr("Localizable", "Common.Warning")

    internal enum Process {
      /// Process couldn't be finished.
      internal static let error = L10n.tr("Localizable", "Common.Process.Error")
      /// Process has been finished successfully.
      internal static let success = L10n.tr("Localizable", "Common.Process.Success")
    }
  }

  internal enum Coupon {
    ///  credits will be transfered from your wallet.
    internal static let buyCoupon = L10n.tr("Localizable", "Coupon.BuyCoupon")
    /// Your credit is not enough to buy this coupon.
    internal static let notEnough = L10n.tr("Localizable", "Coupon.NotEnough")
    /// Credit Not Enough
    internal static let notEnoughTitle = L10n.tr("Localizable", "Coupon.NotEnoughTitle")
    /// Coupon
    internal static let title = L10n.tr("Localizable", "Coupon.Title")
  }

  internal enum Credit {
    /// Set requiremnt fields.
    internal static let addCredit = L10n.tr("Localizable", "Credit.AddCredit")
    /// Can't add a new credit!
    internal static let addError = L10n.tr("Localizable", "Credit.AddError")
    /// Added a new credit!
    internal static let addSuccess = L10n.tr("Localizable", "Credit.AddSuccess")
    /// Number of Credits
    internal static let numberOfCredit = L10n.tr("Localizable", "Credit.NumberOfCredit")
    /// Price
    internal static let price = L10n.tr("Localizable", "Credit.Price")
    /// Credit
    internal static let title = L10n.tr("Localizable", "Credit.Title")
    /// Update requiremnt fields.
    internal static let updateCredit = L10n.tr("Localizable", "Credit.UpdateCredit")
  }

  internal enum Match {
    /// Basketball
    internal static let basketball = L10n.tr("Localizable", "Match.Basketball")
    /// Football
    internal static let football = L10n.tr("Localizable", "Match.Football")
  }

  internal enum Matchform {
    /// Away Team
    internal static let awayTeam = L10n.tr("Localizable", "MatchForm.AwayTeam")
    /// Bet
    internal static let bet = L10n.tr("Localizable", "MatchForm.Bet")
    /// Bet ID
    internal static let betID = L10n.tr("Localizable", "MatchForm.BetID")
    /// Country
    internal static let country = L10n.tr("Localizable", "MatchForm.Country")
    /// Date
    internal static let date = L10n.tr("Localizable", "MatchForm.Date")
    /// For coupons, you should set special field.
    internal static let footerTitle = L10n.tr("Localizable", "MatchForm.FooterTitle")
    /// Please set all fields.
    internal static let headerTitle = L10n.tr("Localizable", "MatchForm.HeaderTitle")
    /// Home Team
    internal static let homeTeam = L10n.tr("Localizable", "MatchForm.HomeTeam")
    /// Is it special?
    internal static let isCoupon = L10n.tr("Localizable", "MatchForm.isCoupon")
    /// League
    internal static let league = L10n.tr("Localizable", "MatchForm.League")
    /// Odd
    internal static let odd = L10n.tr("Localizable", "MatchForm.Odd")
    /// SAVE MATCH
    internal static let saveMatch = L10n.tr("Localizable", "MatchForm.SaveMatch")
    /// Status
    internal static let status = L10n.tr("Localizable", "MatchForm.Status")
    /// Time
    internal static let time = L10n.tr("Localizable", "MatchForm.Time")
    /// Tipster
    internal static let tipster = L10n.tr("Localizable", "MatchForm.Tipster")
    /// Type
    internal static let type = L10n.tr("Localizable", "MatchForm.Type")
    /// Web Site
    internal static let webSite = L10n.tr("Localizable", "MatchForm.WebSite")
    /// Won
    internal static let won = L10n.tr("Localizable", "MatchForm.Won")

    internal enum Awayteam {
      /// Real Madrid
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.AwayTeam.Placeholder")
    }

    internal enum Bet {
      /// MS-2
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Bet.Placeholder")
    }

    internal enum Betid {
      /// 740
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.BetID.Placeholder")
    }

    internal enum Country {
      /// spain
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Country.Placeholder")
    }

    internal enum Hometeam {
      /// Barcelona
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.HomeTeam.Placeholder")
    }

    internal enum League {
      /// ESP
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.League.Placeholder")
    }

    internal enum Matchtype {
      /// 1 or 2
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.MatchType.Placeholder")
    }

    internal enum Odd {
      /// 1.77
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Odd.Placeholder")
    }

    internal enum Status {
      /// 0
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Status.Placeholder")
    }

    internal enum Tipster {
      /// mustafa@gmail.com
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Tipster.Placeholder")
    }

    internal enum Website {
      /// BetMe
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.WebSite.Placeholder")
    }

    internal enum Won {
      /// 0 or 1
      internal static let placeholder = L10n.tr("Localizable", "MatchForm.Won.Placeholder")
    }
  }

  internal enum Role {
    /// Administrator
    internal static let admin = L10n.tr("Localizable", "Role.Admin")
    /// Moderator
    internal static let moderator = L10n.tr("Localizable", "Role.Moderator")
    /// User
    internal static let user = L10n.tr("Localizable", "Role.User")
  }

  internal enum User {

    internal enum Action {
      /// Please select an action.
      internal static let desc = L10n.tr("Localizable", "User.Action.Desc")
      /// User Actions
      internal static let title = L10n.tr("Localizable", "User.Action.Title")
    }

    internal enum Credit {
      /// Your rest of credit: 
      internal static let rest = L10n.tr("Localizable", "User.Credit.Rest")
    }

    internal enum Role {
      /// Admin
      internal static let admin = L10n.tr("Localizable", "User.Role.Admin")
      /// Change User's Role
      internal static let changeRole = L10n.tr("Localizable", "User.Role.ChangeRole")
      /// Disable User
      internal static let disable = L10n.tr("Localizable", "User.Role.Disable")
      /// Enable User
      internal static let enable = L10n.tr("Localizable", "User.Role.Enable")
      /// Moderator
      internal static let moderator = L10n.tr("Localizable", "User.Role.Moderator")
      /// User Role
      internal static let title = L10n.tr("Localizable", "User.Role.Title")
      /// User
      internal static let user = L10n.tr("Localizable", "User.Role.User")
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
