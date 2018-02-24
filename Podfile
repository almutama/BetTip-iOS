source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.2'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
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
  pod 'SwiftMessages'
  pod 'Hero'
  pod 'DZNEmptyDataSet'
  pod 'VegaScrollFlowLayout'
end

def reactive_pods
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa'
    pod 'RxOptional'
    pod 'RxDataSources'
    pod 'Reactant', '~> 1.0', :subspecs => ['Core', 'Result', 'Validation', 'StaticMap', 'Configuration']
end

def general_pods
  pod 'ObjectMapper'
  pod 'ReachabilitySwift'
  pod 'Result', '~> 3.0.0'
  pod 'SwiftGen'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'SwiftKeychainWrapper'
  pod 'IQKeyboardManagerSwift'
  
  plugin 'cocoapods-keys', {
      :project => "BetTip",
      :target => "BetTip",
      :keys => [
      "HeyzapID",
      "HockeyID"
      ]
  }
end

def tracking_pods
  pod 'PaperTrailLumberjack/Swift'
  pod 'HockeySDK'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SwiftLint'
end

def ad_pods
  pod 'Heyzap'
end

target 'BetTip' do
  firebase_pods
  general_pods
  reactive_pods
  tracking_pods
  ui_pods
  ad_pods
end

target 'BetTipTests' do
  testing_pods
  firebase_pods
  general_pods
  reactive_pods
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
