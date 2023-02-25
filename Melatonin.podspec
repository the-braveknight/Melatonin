#
# Be sure to run `pod lib lint Melatonin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Melatonin'
  s.version          = '0.1.0'
  s.summary          = 'A protocol-oriented, type-safe, and easy-to-use networking layer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Melatonin library is a networking library written in Swift that provides a protocol-oriented approach to load requests in a type-safe way.
                       DESC

  s.homepage         = 'https://github.com/the-braveknight/Melatonin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'the-braveknight' => 'zaid.riadh@gmail.com' }
  s.source           = { :git => 'https://github.com/the-braveknight/Melatonin.git', :tag => s.version.to_s }
  s.swift_version = '5.0' 
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  
  s.source_files = 'Sources/**/*'
end
