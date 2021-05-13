Pod::Spec.new do |s|

  s.name         = "XCNavigationDropdownMenu"
  s.version      = "1.0.4"
  s.summary      = "NavigationDropdownMenu"

  s.description  = "NavigationDropdownMenu自定义下拉导航列表"

  s.homepage     = "https://github.com/fanxiaocong/XCNavigationDropdownMenu"

  s.license      = "MIT"


  s.author       = { "樊小聪" => "1016697223@qq.com" }


  s.source       = { :git => "https://github.com/fanxiaocong/XCNavigationDropdownMenu.git", :tag => s.version }


  s.source_files = "XCNavigationDropdownMenu"
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.frameworks   =  'UIKit'

end

