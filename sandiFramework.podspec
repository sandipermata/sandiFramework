Pod::Spec.new do |s|

  s.name         = "sandiFramework"
  s.version      = "1.0.5"
  s.summary      = "this sandiFramework will be create and hopefully help developer and integration into project"
  s.description  = "this is sample framework will be create and hopefully help developer for develop the apps, and this library will be updated "
  s.homepage     = "https://github.com/sandipermata/sandiFramework"
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "sandi" => "sandy.spyware@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/sandipermata/sandiFramework.git", :tag => "#{s.version}" }
  s.source_files  = "sandiFramework/**/*.{swift}"

  s.resource_bundles = {
	'sandiFramework' => ['Pod/Classes/**/*.{storyboard,xib,xcassets,json,imageset,png,ttf,otf}']
  }

  s.resources = "sandiFramework/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,ttf,otf}"

  s.framework = "UIKit"
  s.dependency 'Alamofire', '~> 4.9.1'
  s.dependency 'ReachabilitySwift', '~> 5.0.0'
  s.dependency 'SVGKit', '~> 2.1.1'
  s.dependency 'CocoaLumberjack', '~> 3.6.1'

  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.swift_version = "5.0"
end
