#
# Be sure to run `pod lib lint Melatonin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Melatonin'
  s.version          = '0.3.0'
  s.summary          = 'A protocol-oriented, type-safe, and declarative networking library for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Melatonin is a Swift networking library that provides a protocol-oriented approach to building and managing HTTP requests in a type-safe, declarative, and composable way.
It simplifies working with APIs by leveraging Swift’s powerful features like protocols and type safety.
                       DESC

  s.homepage         = 'https://github.com/the-braveknight/Melatonin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'the-braveknight' => 'zaid.riadh@gmail.com' }
  s.source           = { :git => 'https://github.com/the-braveknight/Melatonin.git', :tag => s.version.to_s }
  s.swift_version = '5.9'
  
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  
  s.source_files = 'Sources/**/*'
end
