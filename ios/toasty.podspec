#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'toasty'
  s.version          = '0.0.1'
  s.summary          = 'a flutter package for show toast'
  s.description      = <<-DESC
a flutter package for show toast
                       DESC
  s.homepage         = 'https://github.com/AliHoseinpoor/toasty'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Ali Hoseinpoor' => 'iamhoseinpoor@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

