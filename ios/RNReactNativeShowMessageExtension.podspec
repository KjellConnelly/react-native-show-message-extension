
Pod::Spec.new do |s|
  s.name         = "RNReactNativeShowMessageExtension"
  s.version      = "1.0.0"
  s.summary      = "RNReactNativeShowMessageExtension"
  s.description  = <<-DESC
                  RNReactNativeShowMessageExtension
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNReactNativeShowMessageExtension.git", :tag => "master" }
  s.source_files  = "RNReactNativeShowMessageExtension/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  