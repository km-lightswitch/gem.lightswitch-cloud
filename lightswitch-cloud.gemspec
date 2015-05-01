Gem::Specification.new do |s|

  s.name                = 'lightswitch-cloud'
  s.version             = '0.0.2'
  s.date                = '2015-03-24'
  s.summary             = 'Turn instances on and off in the cloud at will!'
  s.description         = 'Implements functionality in lightswitch for AWS!'
  s.authors             = ['Krishnan M']
  s.email               = 'km@krishnanm.com'
  s.files               = Dir['lib/**/*.rb']
  s.add_development_dependency 'riot'
  s.add_runtime_dependency 'aws-sdk'
  s.homepage            = 'http://rubygems.org/gems/lightswitch-cloud'
  s.license             = 'MIT'

end
