
# Be sure to run `pod lib lint XComm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XComm'
  s.version          = '0.1.3'
  s.summary          = 'XComm libary.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        XComm libary created by xihongjian.
                       DESC

  s.homepage         = 'https://github.com/xihongjian/XComm'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xpg' => 'xipg@cmmobi.com' }
  s.source           = { :git => 'https://github.com/xihongjian/XComm.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XComm/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XComm' => ['XComm/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.public_header_files = 'XComm/Classes/**/*.h',"$(PODS_ROOT)/**/*.h"
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 3.1.0'
   s.libraries = 'sqlite3'
end
