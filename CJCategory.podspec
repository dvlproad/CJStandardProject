Pod::Spec.new do |s|

  s.name         = "CJCategory"
  s.version      = "0.0.5"
  s.summary      = "在0.0.5停止使用，改为分别放在对应的CJBaseUIKit或CJFoundation中"
  s.homepage     = "https://github.com/dvlproad/CJFoundation"

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "lichq" => "" }

  s.platform     = :ios
 
  s.source       = { :git => "https://github.com/dvlproad/CJFoundation.git", :tag => "delete_pod_CJCategory_0.0.5" }
  s.source_files  = "CJFoundation/**/*.{h,m}"


  s.deprecated = true

end
