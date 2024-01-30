platform :ios, '13.0'

source 'https://cdn.cocoapods.org/'

inhibit_all_warnings!

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                  config.build_settings['EXCLUDEDARCHS'] = 'arm64'
               end
          end
   end
end

target 'MyProduct' do
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
  pod 'MPInjector'
  pod 'LocalDataViewer'
  pod 'XCGLogger'

  target 'MyProductTests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
  end

end
