require 'test_helper'
require 'rack/mock'

class Rack::GoogleAnalyticsTest < Test::Unit::TestCase

  def test_embed_tracking_code_at_the_end_of_html_body
    assert_match TRACKER_EXPECT, request.body
  end

  def test_embed_tracking_code_in_xhtml_documents
    assert_match TRACKER_EXPECT, request(:content_type => "application/xhtml+xml").body
  end

  def test_dont_embed_code_in_non_html_documents
    assert_no_match TRACKER_EXPECT, request(:content_type => "text/xml", :body => [XML_DOC]).body 
  end

  def test_should_not_raise_exception_if_theres_no_html_body_tag
    assert_nothing_raised { request(:body => ["<html></html>"]) }
  end

  def test_shoud_buff_content_length_by_the_size_of_tracker_code
    assert_equal HTML_DOC.length + 406, request.content_length
  end

  private

    TRACKER_EXPECT = /<script.*pageTracker.*<\/script>\s?<\/body>/m

    HTML_DOC = <<-EOF
    <html>
      <head>
        <title>Rack::GoogleAnalytics</title>
      </head>
      <body>
        <h1>Rack::GoogleAnalytics</h1>
      </body>
    </html>
    EOF

    XML_DOC = <<-EOF
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <poem>
      <title>Old Pond</title>
      <author>Matsuo Basho</author>
      <body>an ancient pond / a frog jumps in / the splash of water</body>
    </poem>
    EOF

    def request opts = {}
      Rack::MockRequest.new(app(opts)).get("/")
    end

    def app opts = {}
      opts[:content_type] ||= "text/html"
      opts[:body]         ||= [HTML_DOC]
      rack_app = lambda { |env| [200, { 'Content-Type' => opts[:content_type] }, opts[:body]] }
      Rack::GoogleAnalytics.new(rack_app, :web_property_id => "UA-0000000-1")
    end

end
