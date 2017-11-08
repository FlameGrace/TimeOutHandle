#
#  Be sure to run `pod spec lint TimeOutHandle.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TimeOutHandle"
  s.version      = "0.0.1"
  s.summary      = "A timeout handle tool for iOS."
  s.homepage     = "https://github.com/FlameGrace/TimeOutHandle"
  s.license      = "BSD"
  s.author             = { "FlameGrace" => "flamegrace@hotmail.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/FlameGrace/TimeOutHandle.git", :tag => "0.0.1" }
  s.source_files  = "TimeOutHandle", "TimeOutHandle/**/*.{h,m}"
  s.public_header_files = "TimeOutHandle/**/*.h"
end
