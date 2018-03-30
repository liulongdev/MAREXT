Pod::Spec.new do |s|
  s.name         = "MAREXT"
  s.version      = "0.0.9"
  s.summary      = "Some category and light tool."
  s.description  = <<-DESC
    Some category and light tool, and performace.
                   DESC
  s.homepage     = "https://github.com/liulongdev/MAREXT"
  s.license      = "MIT"
  s.author       = { "liulongdev" => "305708612@qq.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  #s.source       = { :git => "https://github.com/liulongdev/MAREXT.git", :tag => "#{s.version}" }
  #s.source_files = "MAREX/**/*.{h,m}"
  s.requires_arc = true

  s.public_header_files = 'MAREX/MARExtension/MARCategory.h'
  s.subspec 'MARModel' do |MARModel|
      MARModel.source_files = 'MAREX/MARModel/**/*'
  end
 
  s.subspec 'RuntimeOBJ' do |RuntimeOBJ|
      RuntimeOBJ.source_files = 'MAREX/MARExtension/RuntimeOBJ/**/*'
  end
 
  s.subspec 'Debug' do |Debug|
      Debug.source_files = 'MAREX/MARExtension/Debug/**/*'
  end
 
  s.subspec 'Foundation' do |Foundation|
      Foundation.source_files = 'MAREX/MARExtension/Foundation/**/*'
  end
  
  s.subspec 'Quartz' do |Quartz|
      Quartz.source_files = 'MAREX/MARExtension/Quartz/**/*'
  end
  
  s.subspec 'UIKit' do |UIKit|
      UIKit.source_files = 'MAREX/MARExtension/UIKit/**/*'
  end
  
  s.library   = "z"
  # s.libraries = "z", "z"
  
end
