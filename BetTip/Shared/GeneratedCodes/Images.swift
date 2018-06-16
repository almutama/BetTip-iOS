// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
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

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum TabBar {
    internal static let tabSelBasketball = ImageAsset(name: "tabSel_basketball")
    internal static let tabSelCoupon = ImageAsset(name: "tabSel_coupon")
    internal static let tabSelFootball = ImageAsset(name: "tabSel_football")
    internal static let tabSelMore = ImageAsset(name: "tabSel_more")
    internal static let tabSelPremium = ImageAsset(name: "tabSel_premium")
    internal static let tabBasketball = ImageAsset(name: "tab_basketball")
    internal static let tabCoupon = ImageAsset(name: "tab_coupon")
    internal static let tabFootball = ImageAsset(name: "tab_football")
    internal static let tabMore = ImageAsset(name: "tab_more")
    internal static let tabPremium = ImageAsset(name: "tab_premium")
  }
  internal static let active = ImageAsset(name: "active")
  internal static let background = ImageAsset(name: "background")
  internal static let bahisInterface = ImageAsset(name: "bahis_interface")
  internal static let bannerBackground = ImageAsset(name: "banner_background")
  internal static let basketball = ImageAsset(name: "basketball")
  internal static let basketballEx = ImageAsset(name: "basketball_ex")
  internal static let credit = ImageAsset(name: "credit")
  internal static let cross = ImageAsset(name: "cross")
  internal static let deal = ImageAsset(name: "deal")
  internal static let football = ImageAsset(name: "football")
  internal static let footballEx = ImageAsset(name: "football_ex")
  internal static let logo = ImageAsset(name: "logo")
  internal static let logoTr = ImageAsset(name: "logo_tr")
  internal static let lost = ImageAsset(name: "lost")
  internal static let matchResult = ImageAsset(name: "match_result")
  internal static let noAds = ImageAsset(name: "no_ads")
  internal static let push = ImageAsset(name: "push")
  internal static let statsEx = ImageAsset(name: "stats_ex")
  internal static let twitter = ImageAsset(name: "twitter")
  internal static let versus = ImageAsset(name: "versus")
  internal static let won = ImageAsset(name: "won")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
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
    credit,
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
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
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

internal extension AssetColorTypeAlias {
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
