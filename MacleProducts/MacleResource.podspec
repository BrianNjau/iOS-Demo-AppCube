Pod::Spec.new do |s|
    s.name             = 'MacleResource'
        s.version          = "23.9.0"
        s.authors      = 'Front End Group'
    s.homepage      = 'Front End Group'
    s.source      = {:git => '', :tag => ''}
    s.summary          = 'MacleResource for Macle IOS SDK.'
    s.description      = 'MacleResource for Macle IOS SDK.'
    s.resource_bundle = {
      'MacleResource' => ['MacleResource/*']
    }
end
  