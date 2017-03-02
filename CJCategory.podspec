Pod::Spec.new do |s|
  s.name         = "CJCategory"
  s.version      = "0.0.3"
  s.summary      = "NSObject和UIView的类目"
  s.homepage     = "https://github.com/dvlproad/CJFoundation"
  s.license      = "MIT"
  s.author             = "dvlproad"
  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJFoundation.git", :tag => "CJCategory_0.0.3" }
  # s.source_files  = "CJCategory/**/*.{h,m}"
  # s.resources = "RadioButtons/**/*.{png,xib}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.vendored_libraries = '/Pod/Classes/*.a' #代码中包含静态库

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'NSData' do |ss|
    ss.source_files = "CJCategory/NSData/*.{h,m}"
  end

  s.subspec 'NSDate' do |ss|
    ss.source_files = "CJCategory/NSDate/*.{h,m}"
  end

  s.subspec 'NSDictionary' do |ss|
    ss.source_files = "CJCategory/NSDictionary/*.{h,m}"
  end

  s.subspec 'NSString' do |ss|
    ss.source_files = "CJCategory/NSString/*.{h,m}"
  end

  s.subspec 'UIImage' do |ss|
    ss.source_files = "CJCategory/UIImage/*.{h,m}"
  end

  s.subspec 'UIView' do |ss|
    ss.source_files = "CJCategory/UIView/*.{h,m}"
  end

end
