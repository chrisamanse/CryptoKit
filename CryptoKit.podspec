Pod::Spec.new do |s|
  s.name         = "CryptoKit"
  s.version      = "0.3.3"
  s.summary      = "Pure Swift implementations of cryptographic functions"
  s.description  = <<-DESC
                    CryptoKit is a Swift framework containing implementations of cryptographic functions.
                   DESC
  
  s.homepage     = "https://github.com/chrisamanse/CryptoKit"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "Chris Amanse" => "chris@chrisamanse.xyz" }
  
  s.social_media_url   = "http://twitter.com/ChrisAmanse"
  
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"
  s.watchos.deployment_target = "2.0"
  
  s.source       = { :git => "https://github.com/chrisamanse/CryptoKit.git", :tag => "#{s.version}" }
  
  s.source_files  = "Sources", "Sources/**/*.{h,swift}"
  
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
