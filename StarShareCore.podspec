Pod::Spec.new do |s|
  s.name         = "StarShareCore"
  s.version      = "0.0.1"
  s.summary      = "Network abstraction layer written in Swift with Moya"
  s.description  = <<-EOS
  StarShareCore abstracts network commands using Swift Generics to provide developers
  with more compile-time confidence.
  ReactiveSwift and RxSwift extensions exist as well. Instructions for installation
  are in [the README](https://github.com/StarShare/StarShareCore).
  EOS
  s.homepage     = "https://github.com/StarShare/StarShareCore"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "wangrui" => "wangrui@bangbangbang.cn" }
  s.social_media_url   = "http://oye.moe"
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/StarShare/StarShareCore.git", :tag => s.version }
  s.source_files  = "StarShareCore/**/*.swift"
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0'
  }
  s.dependency "Alamofire"
  s.dependency "Moya"
  s.dependency "SwiftyJSON"
  s.dependency "HandyJSON", "~>4.0.0-beta.1"
  s.dependency "ReactiveCocoa"
  s.dependency "Cache"
  s.framework = "Foundation"
end