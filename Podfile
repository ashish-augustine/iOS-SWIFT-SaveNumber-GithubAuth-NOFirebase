# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'SaveNumber' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SaveNumber
  pod 'Moya/RxSwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ReactiveSwift'
  pod 'ProgressHUD', '~> 13.8.6'
  pod 'SwifterSwift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13'
    end
  end
end
