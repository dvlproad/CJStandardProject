Pod::Spec.new do |s|
  #查看本地已同步的pod库：pod repo
  #验证方法：pod lib lint CQDemoKit-Swift.podspec --sources=master --allow-warnings
  #上传方法：pod trunk push CQDemoKit-Swift.podspec --allow-warnings
  s.name         = "CQDemoKit-Swift"
  s.version      = "0.1.0"
  s.summary      = "Demo"
  s.homepage     = "https://github.com/dvlproad/001-UIKit-CQDemo-iOS"

  s.description  = <<-DESC
                 - CQDemoKit-Swift/xxx：Demo最基础类

                   A longer description of CJHook in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://github.com/dvlproad/001-UIKit-CQDemo-iOS.git", :tag => "CQDemoKit-Swift_0.1.0" }
  #s.source_files  = "CQDemoKit-Swift/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  

  s.subspec 'BaseVC' do |ss|
    ss.source_files = "CQDemoKit-Swift/BaseVC/**/*.{swift}"
    ss.dependency 'SnapKit'

    # ss.subspec 'TextView' do |sss|
    #   sss.source_files = "CQDemoKit-Swift/BaseVC/TextView/**/*.{h,m}"
    #   sss.dependency 'CQDemoKit-Swift/BaseVC/Base'
    #   sss.dependency 'CQDemoKit-Swift/BaseUtil'
    # end
  end


  # # Demo 工程中基本都需要的 Resource
  # s.subspec 'Demo_Resource' do |ss|
  #   ss.source_files = "CQDemoKit-Swift/Demo_Resource/**/*.{h,m}"
  #   ss.resource_bundle = {
  #     'CQDemoKit-Swift' => ['CQDemoKit-Swift/Demo_Resource/**/*.{png,jpg}'] # CQDemoKit-Swift 为生成boudle的名称，可以随便起，但要记住，库里要用
  #   }
  # end

  # s.subspec 'BaseUIKit' do |ss|
  #   ss.source_files = "CQDemoKit-Swift/BaseUIKit/**/*.{h,m}"
  #   ss.dependency 'Masonry'
  # end

  # s.subspec 'BaseUtil' do |ss|
  #   ss.source_files = "CQDemoKit-Swift/BaseUtil/**/*.{h,m}"
  # end


end
