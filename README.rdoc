= Rack::GoogleAnalytics

Rack middleware to embed Google Analytics tracking code.

== Usage

  require "rack/google_analytics"

  use Rack::GoogleAnalytics, :web_property_id => "UA-000000-1"

  app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, '<html><body></body></html>'] }
  run app

== Configuring for a Rails App

In your `Gemfile`:

  gem 'rack-google_analytics'

In your `config/application.rb`

  config.middleware.use "Rack::GoogleAnalytics", :web_property_id => "UA-0000000-1"

== TODO and Motivations

This isn't very "feature rich", because I've mostly written it as an
excuse to learn more about rack. Hell, it's possible someone has already done
it (and better); I didn't bother to look. See the notes below on contributing
fixes for these deficiencies. 

* Support for the various tracking options (http://code.google.com/apis/analytics/docs/gaJS/gaJSApi.html)
* Legacy tracking code

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
  bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2011 Jason L Perry. See LICENSE for details.
