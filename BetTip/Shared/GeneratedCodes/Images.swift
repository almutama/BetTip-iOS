// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  typealias AssetColorTypeAlias = NSColor
  typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias AssetColorTypeAlias = UIColor
  typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
typealias AssetType = ImageAsset

struct ImageAsset {
  fileprivate var name: String

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

struct ColorAsset {
  fileprivate var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum TabBar {
    static let tabSelBasketball = ImageAsset(name: "tabSel_basketball")
    static let tabSelCoupon = ImageAsset(name: "tabSel_coupon")
    static let tabSelFootball = ImageAsset(name: "tabSel_football")
    static let tabSelMore = ImageAsset(name: "tabSel_more")
    static let tabSelPremium = ImageAsset(name: "tabSel_premium")
    static let tabBasketball = ImageAsset(name: "tab_basketball")
    static let tabCoupon = ImageAsset(name: "tab_coupon")
    static let tabFootball = ImageAsset(name: "tab_football")
    static let tabMore = ImageAsset(name: "tab_more")
    static let tabPremium = ImageAsset(name: "tab_premium")
  }
  static let active = ImageAsset(name: "active")
  static let background = ImageAsset(name: "background")
  static let bahisInterface = ImageAsset(name: "bahis_interface")
  static let bannerBackground = ImageAsset(name: "banner_background")
  static let basketball = ImageAsset(name: "basketball")
  static let basketballEx = ImageAsset(name: "basketball_ex")
  static let cross = ImageAsset(name: "cross")
  static let deal = ImageAsset(name: "deal")
  static let football = ImageAsset(name: "football")
  static let footballEx = ImageAsset(name: "football_ex")
  static let logo = ImageAsset(name: "logo")
  static let logoTr = ImageAsset(name: "logo_tr")
  static let lost = ImageAsset(name: "lost")
  static let matchResult = ImageAsset(name: "match_result")
  static let noAds = ImageAsset(name: "no_ads")
  static let push = ImageAsset(name: "push")
  static let statsEx = ImageAsset(name: "stats_ex")
  static let twitter = ImageAsset(name: "twitter")
  static let versus = ImageAsset(name: "versus")
  static let won = ImageAsset(name: "won")

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    TabBar.tabSelBasketball,
    TabBar.tabSelCoupon,
    TabBar.tabSelFootball,
    TabBar.tabSelMore,
    TabBar.tabSelPremium,
    TabBar.tabBasketball,
    TabBar.tabCoupon,
    TabBar.tabFootball,
    TabBar.tabMore,
    TabBar.tabPremium,
    active,
    background,
    bahisInterface,
    bannerBackground,
    basketball,
    basketballEx,
    cross,
    deal,
    football,
    footballEx,
    logo,
    logoTr,
    lost,
    matchResult,
    noAds,
    push,
    statsEx,
    twitter,
    versus,
    won,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
