#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint evergage_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'evergage_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Interaction Studio (Formerly Evergage) Plugin for Flutter'
  s.description      = <<-DESC
Interaction Studio (Formerly Evergage) Plugin for Flutter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Evergage'
  s.static_framework = true
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
