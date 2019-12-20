
Pod::Spec.new do |s|
  s.name         = "RNReactNativeShowMessageExtension"
  s.version      = "1.0.15"
  s.summary      = "RNReactNativeShowMessageExtension"
  s.description  = <<-DESC
                  Shows your iMessage App Extension and delivers info to it. You must handle the code that is sent yourself though. iOS only.
                   DESC
  s.homepage     = "https://github.com/author/RNReactNativeShowMessageExtension.git"
  s.license      = "MIT"
  s.author             = { "Kjell Connelly" => "kjellapps@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNReactNativeShowMessageExtension.git", :tag => "v#{s.version}" }
  s.source_files  = "RNReactNativeShowMessageExtension/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end
