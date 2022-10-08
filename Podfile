platform :ios, '12.0'

source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
end

target 'MyApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyApp
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'
  pod 'Reusable'
  pod 'MJRefresh'
  pod 'PKHUD'
  pod 'FirebaseMessaging'
  pod 'FirebaseAnalytics'
  pod 'FirebaseCrashlytics'
  pod 'XCGLogger'
  pod 'MPInjector'
  pod 'LocalDataViewer'

  target 'MyAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
