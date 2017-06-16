Pod::Spec.new do |s|
  s.name         = "MAREXT"
  s.version      = "0.0.1"
  s.summary      = "Some category and light tool."
  s.description  = <<-DESC
    Some category and light tool.
                   DESC
  s.homepage     = "https://github.com/liulongdev/MAREXT"
  s.license      = "MIT"
  s.author       = { "liulongdev" => "305708612@qq.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/liulongdev/MAREXT.git", :tag => "#{s.version}" }
  s.source_files = "MAREX/**/*.{h,m}"
  s.requires_arc = true
end
