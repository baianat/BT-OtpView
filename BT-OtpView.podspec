#
# Be sure to run `pod lib lint BT-OtpView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BT-OtpView'
    s.version          = '0.1.1'
    s.summary          = 'An off-the-shelf One-Time-Password View For iOS.'
    
    
    s.description      = <<-DESC
    "BT-Otp is an easy-to-use, fully customized one-time-password view to use in your iOS apps."
    DESC
    
    s.homepage         = 'https://github.com/baianat/BT-OtpView'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Baianat' => 'development@baianat.com' }
    s.source           = { :git => 'https://github.com/baianat/BT-OtpView.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '11.0'
    s.swift_version = '5.0'
    s.source_files = 'BT-OtpView/Classes/**/*'
    s.frameworks = 'UIKit'
    
end
