Pod::Spec.new do |s|
  s.name = 'Pagination'
  s.ios.deployment_target = '9.0'
  s.version = '1.0'
  s.authors = 'manhpham90vn'
  s.license = 'MIT'
  s.source = { :git => 'https://github.com/manhpham90vn/iOS-VIPER-Architecture/tree/master/Library/Pagination' }
  s.homepage = 'https://github.com/manhpham90vn/iOS-VIPER-Architecture'
  s.summary = 'Pagination'
  s.source_files = 'Library/Pagination/*.swift'
  s.dependency 'RxSwift', '~> 6.2'
  s.dependency 'RxCocoa', '~> 6.2'
  s.dependency 'MJRefresh'
  s.dependency 'NSObject+Rx'
end
