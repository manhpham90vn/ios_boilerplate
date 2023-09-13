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
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                  config.build_settings['EXCLUDEDARCHS'] = 'arm64'
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
    pod 'MockingbirdFramework', '~> 0.20'
  end

end
EOF
