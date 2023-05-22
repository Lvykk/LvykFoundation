#
# Be sure to run `pod lib lint LvykFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LvykFoundation'
  s.version          = '1.0.0'
  s.summary          = 'A short description of LvykFoundation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "A tool class for secondary packaging of network and cache libraries"

  s.homepage         = 'https://github.com/Lvykk/LvykFoundation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lvyk' => 'lvyk1029@gmail.com' }
  s.source           = { :git => 'https://github.com/Lvykk/LvykFoundation.git', :tag => s.version }

  s.ios.deployment_target = '11.0'
  
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  
#  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  
  s.requires_arc = true
    
  s.subspec "Cache" do |cache|
      cache.source_files  = "LvykFoundation/Classes/Cache/**/*"
  end
  
  s.subspec "Decodable" do |decodable|
      decodable.source_files  = "LvykFoundation/Classes/Decodable/**/*"
  end
  
  s.subspec "Effects" do |effects|
      effects.source_files  = "LvykFoundation/Classes/Effects/**/*"
      effects.ios.framework = "CoreImage"
      effects.ios.framework = "Accelerate"
  end
  
  s.subspec "Macro" do |macro|
      macro.source_files  = "LvykFoundation/Classes/Macro/**/*"
  end
  
  s.subspec "Network" do |network|
      network.source_files  = "LvykFoundation/Classes/Network/**/*"
  end
  
  s.subspec "NSDecimalNumber" do |num|
      num.source_files  = "LvykFoundation/Classes/NSDecimalNumber/**/*"
  end
  
  s.ios.framework = "UIKit"
  
  s.dependency "Moya", "~> 15.0.0"
  s.dependency "BigInt", "~> 5.2.0"
  s.dependency "Cache", "~> 6.0.0"
  
end
