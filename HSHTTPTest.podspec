#
# Be sure to run `pod lib lint HSHTTPTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HSHTTPTest"
  s.version          = "0.1.0"
  s.summary          = "Test your website or web services from Xcode."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  You have a Website or Web service. You know your way around testing within Xcode. 
  You should probably have some tests for your Website too.
  This makes it easy to write those tests and run them in an environment you already understand.
                       DESC

  s.homepage         = "https://github.com/ConfusedVorlon/HSHTTPTest"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Rob" => "Rob@HobbyistSoftware.com" }
  s.source           = { :git => "https://github.com/ConfusedVorlon/HSHTTPTest.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.osx.deployment_target = '10.10'

  s.source_files = 'HSHTTPTest/Classes/**/*'
  s.resource_bundles = {
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'XCTest'
  # s.dependency 'AFNetworking', '~> 2.3'
end
