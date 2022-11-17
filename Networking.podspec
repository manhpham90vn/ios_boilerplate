Pod::Spec.new do |s|
  s.name = 'Networking'
  s.ios.deployment_target = '10.0'
  s.version = '1.0'
  s.authors = 'manhpham90vn'
  s.license = 'MIT'
  s.source = { :git => 'https://github.com/manhpham90vn/iOS-VIPER-Architecture/tree/master/Library/Networking' }
  s.homepage = 'https://github.com/manhpham90vn/iOS-VIPER-Architecture'
  s.summary = 'Networking'
  s.source_files = 'Library/Networking/*.swift'
  s.dependency 'RxSwift', '~> 6.2'
  s.dependency 'RxCocoa', '~> 6.2'
  s.dependency 'Alamofire'
  s.dependency 'MPInjector'
end
