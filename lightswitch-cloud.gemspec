Gem::Specification.new do |s|

  s.name                = 'lightswitch-cloud'
  s.version             = '0.0.4'
  s.date                = '2015-07-10'
  s.summary             = 'Turn instances on and off in the cloud at will!'
  s.description         = 'Implements functionality in lightswitch for AWS!'
  s.authors             = ['Krishnan M']
  s.email               = 'km@krishnanm.com'
  s.files               = Dir['lib/**/*.rb']
  s.add_development_dependency 'riot', '0.12.7'
  s.add_runtime_dependency 'aws-sdk', '2.1.4'
  s.homepage            = 'http://rubygems.org/gems/lightswitch-cloud'
  s.license             = 'MIT'

end
