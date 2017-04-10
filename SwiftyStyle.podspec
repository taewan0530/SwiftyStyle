Pod::Spec.new do |s|
  s.name             = 'SwiftyStyle'
  s.version          = '0.0.1'
  s.summary          = 'The most sexy way to use images in Swift.'
  s.homepage         = 'https://github.com/taewan0530/SwiftyStyle'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Taewan Kim' => 'taewan0530@daum.net' }
  s.source           = { :git => 'https://github.com/taewan0530/SwiftyStyle.git',
                         :tag => s.version.to_s }
  s.source_files     = 'Sources/**/*.{swift}'
  s.requires_arc     = true

  s.ios.deployment_target = '8.0'
end
