#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

POD_FILE=Podfile

rm -rf $POD_FILE

cat <<EOF >>$POD_FILE
platform :ios, '$DEPLOYMENT_TARGET'

source 'https://cdn.cocoapods.org/'

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

target '$PRODUCT_NAME' do
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

  target '${PRODUCT_NAME}Tests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'Nimble'
    pod 'Quick'
    pod 'MockingbirdFramework', '~> 0.20'
  end

end
EOF