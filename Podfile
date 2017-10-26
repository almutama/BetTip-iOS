source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.2'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

def network_pods
  pod 'Moya/RxSwift', '~> 10.0'
  pod 'ObjectMapper', '~> 2.2'
  #pod 'Moya-ObjectMapper/RxSwift', '~> 2.4.2'
  pod 'ReachabilitySwift'
end

def firebase_pods
  pod 'Firebase/Core'
  pod 'Firebase/Crash'
  pod 'Firebase/Messaging'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
end

def ui_pods
  pod 'NVActivityIndicatorView'
  #pod 'SCLAlertView'
  pod 'SwiftMessages'
  #pod 'Kingfisher'
  pod 'SideMenu'
  pod 'IGListKit'
  pod "Hero"
  pod 'HGPlaceholders'
  pod "VegaScrollFlowLayout"
end

def general_pods
  pod 'CocoaLumberjack/Swift'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'SwiftGen'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
end

def tracking_pods
  pod 'HockeySDK'
  pod 'Crashlytics'
end

def ad_pods
  pod 'Heyzap'
  pod 'FyberSDK'
end

target 'BetTip' do
  network_pods
  firebase_pods
  general_pods
  tracking_pods
  ui_pods
  ad_pods
end

target 'BetTipTests' do
  testing_pods
  network_pods
  firebase_pods
  general_pods
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
