Pod::Spec.new do |s|

  s.name = 'YPublicModule'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.summary = 'PublicModule in Swift'
  s.homepage = 'https://github.com/Yueqingshan/YPublicModule'
  s.authors = { 'Alamofire Software Foundation' => 'info@alamofire.org' }
  s.source = { :git => 'https://github.com/Yueqingshan/YPublicModule.git', :tag => s.version }
  s.ios.deployment_target = '8.0'

  s.source_files = 'Tools/*'

  s.dependency "Alamofire"
  s.dependency "Toast-Swift"

end