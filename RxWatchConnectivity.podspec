#
# Be sure to run `pod lib lint RxWatchConnectivity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxWatchConnectivity'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift extensions for RxWatchConnectivity framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod provides extensions for RxWatchConnectivity framework.
                       DESC

  s.homepage         = 'https://github.com/franciscocgoncalves/RxWatchConnectivity'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'franciscocgoncalves' => 'franciscocgoncalves@gmail.com' }
  s.source           = { :git => 'https://github.com/franciscocgoncalves/RxWatchConnectivity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/franciscocsg'

  s.requires_arc     = true

  s.ios.deployment_target = '9.3'
  s.watchos.deployment_target = '2.3'

  s.source_files = 'RxWatchConnectivity/Classes/Common/**/*'
  s.ios.source_files = 'RxWatchConnectivity/Classes/iOS/**/*'
  s.watchos.source_files = 'RxWatchConnectivity/Classes/watchOS/**/*'

  # s.resource_bundles = {
  #   'RxWatchConnectivity' => ['RxWatchConnectivity/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'WatchConnectivity'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'Result'
end
