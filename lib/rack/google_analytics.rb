module Rack #:nodoc:
  class GoogleAnalytics < Struct.new :app, :options

    def call(env)
      status, headers, response = app.call(env)

      if headers["Content-Type"] =~ /text\/html|application\/xhtml\+xml/
        body = ""
        response.each { |part| body << part }
        index = body.rindex("</body>")
        if index
          body.insert(index, tracking_code(options[:web_property_id]))
          headers["Content-Length"] = body.length.to_s
          response = [body]
        end
      end

      [status, headers, response]
    end

    protected

      # Returns JS to be embeded. This takes one argument, a Web Property ID
      # (aka UA number).
      def tracking_code(web_property_id)
        returning_value = <<-EOF
<script type="text/javascript">
if (typeof gaJsHost == 'undefined') {
  var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
}
</script>
<script type="text/javascript">
try {
var #{options[:prefix]}pageTracker = _gat._getTracker("#{web_property_id}");
EOF
        if options[:multiple_top_level_domains]
          returning_value << <<-EOF          
#{options[:prefix]}pageTracker._setDomainName("none");          
#{options[:prefix]}pageTracker._setAllowLinker(true);          
EOF
        elsif options[:domain_name]
                returning_value << <<-EOF          
      #{options[:prefix]}pageTracker._setDomainName("#{options[:domain_name]}");          
      EOF
        end

        returning_value << <<-EOF
#{options[:prefix]}pageTracker._trackPageview();
} catch(err) {}</script>
EOF
      returning_value
      end
  end
end