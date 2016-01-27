# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'chef/handler'

module BloombergLP
  module EventReportingHandler
    class StartHandler < Chef::Handler
      def initialize(http_url = '', whitelist_attributes = [], sentry_config = {})
        @http_url = http_url
        @whitelist_attributes = whitelist_attributes
        @sentry_config = sentry_config
      end

      def report
        Chef::Log.debug("Running start handler with http_url: #{@http_url}, whitelist_attributes: #{whitelist_attributes} sentry_config: #{@sentry_config} ")
        http_event_reporter = HttpEventReporter.new(@http_url, @whitelist_attributes, @sentry_config, @run_status)
        @run_status.events.register(http_event_reporter)
      end
    end
  end
end
