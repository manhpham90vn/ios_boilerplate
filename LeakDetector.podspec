Pod::Spec.new do |s|
  s.name = 'LeakDetector'
  s.ios.deployment_target = '9.0'
  s.version = '1.0'
  s.authors = 'manhpham90vn'
  s.license = 'MIT'
  s.source = { :git => 'https://github.com/manhpham90vn/iOS-VIPER-Architecture/tree/master/Library/LeakDetector' }
  s.homepage = 'https://github.com/manhpham90vn/iOS-VIPER-Architecture'
  s.summary = 'LeakDetector'
  s.source_files = 'Library/LeakDetector/*.swift'
  s.dependency 'RxSwift', '~> 6.2'
  s.dependency 'RxRelay', '~> 6.2'
end
