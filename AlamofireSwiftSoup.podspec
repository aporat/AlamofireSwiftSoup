Pod::Spec.new do |s|
  s.name                      = 'AlamofireSwiftSoup'
  s.module_name               = 'AlamofireSwiftSoup'
  s.version                   = '1.0.0'
  s.summary                   = 'Alamofire extension for serialize SwiftSoup HTML documents'
  s.homepage                  = 'https://github.com/aporat/AlamofireSwiftSoup'
  s.license                   = 'MIT'
  s.author                    = { 'Adar Porat' => 'http://github.com/aporat' }
  s.platform                  = :ios, '15.0'
  s.ios.deployment_target     = '15.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/aporat/AlamofireSwiftSoup.git', :tag => s.version.to_s }
  s.source_files              = 'AlamofireSwiftSoup/*.{swift}'
  s.swift_version             = '5.2'
  s.dependency 'Alamofire', '~> 5'
  s.dependency 'SwiftSoup', '~> 2'

end
