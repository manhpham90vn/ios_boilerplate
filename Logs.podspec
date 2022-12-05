Pod::Spec.new do |s|
  s.name = 'Logs'
  s.ios.deployment_target = '9.0'
  s.version = '1.0'
  s.authors = 'manhpham90vn'
  s.license = 'MIT'
  s.source = { :git => 'https://github.com/manhpham90vn/iOS-VIPER-Architecture/tree/master/Library/Logs' }
  s.homepage = 'https://github.com/manhpham90vn/iOS-VIPER-Architecture'
  s.summary = 'Logs'
  s.source_files = 'Library/Logs/*.swift'
  s.dependency 'RxSwift', '~> 6.2'
  s.dependency 'RxCocoa', '~> 6.2'
  s.dependency 'MJRefresh'
  s.dependency 'NSObject+Rx'
  s.dependency 'Configs'
  s.dependency 'XCGLogger'
end
