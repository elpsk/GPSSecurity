#
# Be sure to run `pod lib lint GPSSecurity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'GPSSecurity'
  s.version          = '1.0.0'
  s.summary          = 'An SDK to check the validity of the GPS positions related to travel-time distancies.'

  s.description      = <<-DESC
An SDK to check the validity of the GPS positions related to travel-time distancies, to avoid user to mock or to use fake gps utils.
                       DESC

  s.homepage         = 'https://github.com/elpsk/GPSSecurity'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alberto Pasca' => 'alberto.pasca@gmail.com' }
  s.source           = { :git => 'https://github.com/elpsk/GPSSecurity.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.source_files = 'GPSSecurity/Classes/**/*'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'KeychainSwift', '~> 19.0'

end
