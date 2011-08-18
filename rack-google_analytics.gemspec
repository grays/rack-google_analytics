Gem::Specification.new do |spec|
  spec.name        = 'rack-google_analytics'
  spec.version     = '1.0.2'
  spec.authors     = ['Jason L Perry']
  spec.date        = '2011-08-18'
  spec.summary     = 'Google Analytics for Rack applications'
  spec.description = 'Embeds Google Analytics tracking code in the bottom of HTML documents'
  spec.email       = 'jasper@ambethia.com'
  spec.homepage    = 'http://github.com/ambethia/rack-google_analytics'

  spec.extra_rdoc_files = [
     "LICENSE",
     "README.rdoc"
  ]
  spec.files = [
     "README.rdoc",
     "lib/rack-google_analytics.rb",
     "lib/rack/google_analytics.rb"
  ]
  spec.require_paths = %w[lib]
  spec.test_files    = %w[test/rack/google_analytics_test.rb]

  spec.add_dependency 'rack'
end
