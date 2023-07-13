Pod::Spec.new do |s|
  s.name             = 'NestedCollectionView'
  s.version          = '1.0.2'
  s.summary          = 'A collection view that allows nesting of other collection views'
  s.description      = 'NestedCollectionView is a multi-level scrolling view with horizontal scrollable items in a vertical scroll. It supports multiple vertical sections, each with its own set of horizontally scrollable items. Built using Swift and UICollectionView, this view provides an intuitive and interactive way to showcase content with a rich and engaging user interface.'
  s.homepage         = 'https://github.com/DevCrew-io/Nested-Collection-View'
  s.license          = { :type => "MIT" }
  s.author           = { 'DevCrew.IO' => 'founders@devcrew.io' }
  
  s.requires_arc = true
  s.swift_version = "5.0"
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "9.0"
    s.source           = { :git => 'https://github.com/DevCrew-io/Nested-Collection-View.git', :tag => s.version }
  s.source_files     = 'Sources/**/*.swift'
end

