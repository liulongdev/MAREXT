Pod::Spec.new do |s|
  s.name         = "MAREXT"
  s.version      = "0.1.6"
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

  s.source_files = 'MAREX/MARCategory.h'
  s.public_header_files = 'MAREX/MARCategory.h'
  
  s.subspec 'MARModel' do |ss|
      ss.source_files = 'MAREX/MARModel/**/*.{h,m}'
      ss.public_header_files = 'MAREX/MARModel/**/*.h'
  end
 
  s.subspec 'RuntimeOBJ' do |ss|
      ss.source_files = 'MAREX/RuntimeOBJ/**/*.{h,m}'
      ss.public_header_files = 'MAREX/RuntimeOBJ/**/*.h'
      ss.dependency 'MAREXT/MARModel'
  end
 
  s.subspec 'Debug' do |ss|
      ss.source_files = 'MAREX/Debug/**/*.{h,m}'
      ss.public_header_files = 'MAREX/Debug/**/*.h'
      ss.dependency 'MAREXT/Utility'
  end
  
  s.subspec 'Utility' do |ss|
      ss.source_files = 'MAREX/Utility/**/*.{h,m}'
      ss.public_header_files = 'MAREX/Utility/**/*.h'
  end
 
  s.subspec 'Foundation' do |ss|
      ss.source_files = 'MAREX/Foundation/**/*.{h,m}'
      ss.public_header_files = 'MAREX/Foundation/**/*.h'
      ss.dependency 'MAREXT/Utility'
  end
  
  s.subspec 'Quartz' do |ss|
      ss.source_files = 'MAREX/Quartz/**/*.{h,m}'
      ss.public_header_files = 'MAREX/Quartz/**/*.h'
      ss.dependency 'MAREXT/Utility'
  end
  
  s.subspec 'UIKit' do |ss|
      ss.source_files = 'MAREX/UIKit/**/*.{h,m}'
      ss.public_header_files = 'MAREX/UIKit/**/*.h'
      ss.dependency 'MAREXT/Utility'
      ss.dependency 'MAREXT/Foundation'
      ss.dependency 'MAREXT/Quartz'
  end
  
  s.subspec 'ColorArt' do |ss|
      ss.source_files = 'MAREX/ColorArt/**/*.{h,m}'
      ss.public_header_files = 'MAREX/ColorArt/**/*.h'
      ss.dependency 'MAREXT/UIKit'
  end
  
  
  s.library   = "z"
  # s.libraries = "z", "z"
  
end
