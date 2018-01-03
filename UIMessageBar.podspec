Pod::Spec.new do |spec|
    spec.name             = 'UIMessageBar'
    spec.version          = '1.0.0'
    spec.license          = { :type => 'MIT' }
    spec.homepage         = 'https://github.com/Meniny/UIMessageBar'
    spec.authors          = { 'Elias Abel' => 'meniny@qq.com' }
    spec.summary          = 'A very flexible message bar for iOS written in Swift.'
    spec.source           = {:git => 'https://github.com/Meniny/UIMessageBar', :tag => s.version.to_s}
    spec.platform         = :ios, '8.0'
    spec.ios.deployment_target = '8.0'
    spec.source_files     = 'UIMessageBar/**/*.swift'
    spec.resource_bundles = {'UIMessageBar' => ['UIMessageBar/Resources/**/*']}
    spec.framework        = 'UIKit'
    spec.requires_arc     = true
end
