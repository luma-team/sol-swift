Pod::Spec.new do |s|
  s.name             = 'sol-swift'
  s.version          = '0.1'
  s.summary          = 'This implements the basic actions helpful for an iOS Solana wallet.'


  s.description      = <<-DESC
 This is a open source library on pure swift for Solana protocol. 
                       DESC

  s.homepage         = 'https://github.com/luma-team/sol-swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luma' => 'support@lu.ma' }
  s.source           = { :git => 'https://github.com/luma-team/sol-swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = "10.12"
  s.source_files = 'Sources/Solana/**/*'
  s.swift_versions   = ["5.3"]
  s.dependency 'TweetNacl', '~> 1.0.2'
  s.dependency 'CryptoSwift', '~> 1.4.0'
end
