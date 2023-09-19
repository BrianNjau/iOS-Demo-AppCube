Pod::Spec.new do |spec|
    spec.name         = 'MacleKit'
        spec.version      = "23.9.0"
        spec.summary      = 'Macle IOS SDK'
    spec.authors      = 'Front End Group'
    spec.homepage      = 'Front End Group'
    spec.source      = {:git => '', :tag => ''}
    spec.license      = "MIT"
    spec.social_media_url   = ""
    spec.resource_bundle = {
        'MacleResource' => ['MacleResource/*']
    }
    spec.platform = :ios,'9.0'
    spec.ios.deployment_target = '9.0'
    spec.requires_arc = true
    spec.vendored_frameworks = 'MacleKit.framework'
    # 依赖
    spec.dependency 'SSZipArchive'
    spec.dependency 'MJRefresh'
    spec.dependency 'TZImagePickerController'
    spec.dependency 'KSPhotoBrowser'
end
