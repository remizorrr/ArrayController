#
# Be sure to run `pod lib lint ClientCommon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ArrayController'
  s.version          = '0.1.0'
  s.summary          = 'MVVM pattern for UITableView and UICollectionView.'
  s.description      = 'MVVM pattern for UITableView and UICollectionView.'
  s.homepage         = 'https://github.com/remizorrr/ArrayController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'remizorrr' => 'a.y.remizov@gmail.com' }
  s.source           = { :git => 'https://github.com/remizorrr/ArrayController,git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'
  s.resources = 'Resources/*'

end
