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
  s.source       = { :git => "https://github.com/liulongdev/MAREXT.git", :tag => "#{s.version}" }
  
  #s.source_files = "MAREX/**/*.{h,m}"
  s.requires_arc = true

  s.source_files = 'MAREX/MARExtension/MARCategory.h'
  s.public_header_files = 'MAREX/MARExtension/MARCategory.h'
  s.subspec 'MARModel' do |ss|
      ss.source_files = 'MAREX/MARExtension/MARModel/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/MARModel/**/*.h'
  end
 
  s.subspec 'RuntimeOBJ' do |ss|
      ss.source_files = 'MAREX/MARExtension/RuntimeOBJ/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/RuntimeOBJ/**/*.h'
  end
 
  s.subspec 'Debug' do |ss|
      ss.source_files = 'MAREX/MARExtension/Debug/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/Debug/**/*.h'
  end
  
  s.subspec 'Utility' do |ss|
      ss.source_files = 'MAREX/MARExtension/Utility/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/Utility/**/*.h'
  end
 
  s.subspec 'Foundation' do |ss|
      ss.source_files = 'MAREX/MARExtension/Foundation/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/Foundation/**/*.h'
  end
  
  s.subspec 'Quartz' do |ss|
      ss.source_files = 'MAREX/MARExtension/Quartz/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/Quartz/**/*.h'
  end
  
  s.subspec 'UIKit' do |ss|
      ss.source_files = 'MAREX/MARExtension/UIKit/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARExtension/UIKit/**/*.h'
  end
  
  s.library   = "z"
  # s.libraries = "z", "z"
  
end
