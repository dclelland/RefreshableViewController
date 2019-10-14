#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name = "RefreshableViewController"
  s.version = "0.8.0"
  s.summary = "RefreshableViewController is simple view controller with refreshable state management based on PromiseKit."
  s.homepage = "https://github.com/dclelland/RefreshableViewController"
  s.license = { :type => 'MIT' }
  s.author = { "Daniel Clelland" => "daniel.clelland@gmail.com" }
  s.source = { :git => "https://github.com/dclelland/RefreshableViewController.git", :tag => "0.8.0" }
  s.swift_version           = '5.0'
  s.ios.source_files = 'Sources/**/*.swift'
  s.ios.deployment_target = '10.0'
  s.ios.dependency 'PromiseKit', '~> 6.10.0'
end
