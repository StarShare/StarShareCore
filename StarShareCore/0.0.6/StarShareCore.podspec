Pod::Spec.new do |s|
  s.name         = "StarShareCore"
  s.version      = "0.0.6"
  s.summary      = "Network abstraction layer written in Swift with Moya"
  s.description  = <<-EOS
  Something.............................................................
  ..........................Fuck!Nothing!. Instructions for installation
  are in [the README](http://git.idoool.com/iOS_modul/StarShareCore).
  EOS
  s.homepage     = "http://git.idoool.com/iOS_modul/StarShareCore"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "wangrui" => "wangrui@bangbangbang.cn" }
  s.social_media_url   = "http://oye.moe"
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "http://git.idoool.com/iOS_modul/StarShareCore.git", :tag => s.version }
  s.source_files  = "StarShareCorePodSpec/Sources/**/*.swift"
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0'
  }
  s.requires_arc = true
  s.dependency "Alamofire"
  s.dependency "Moya"
  s.dependency "SwiftyJSON"
  s.dependency "HandyJSON", "~>4.0.0-beta.1"
  s.dependency "RxSwift"
  s.dependency "Cache"
  s.framework = "Foundation"
end