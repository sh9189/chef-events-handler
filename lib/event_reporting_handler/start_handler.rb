# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'chef/handler'

module BloombergLP
  module EventReportingHandler
    class StartHandler < Chef::Handler

      def initialize(http_url='',sentry_config={})
        @http_url = http_url
        @sentry_config = sentry_config
      end

      def report
        Chef::Log.debug("Running start handler with http_url: #{@http_url} and sentry_config: #{@sentry_config} ")
        http_event_reporter = HttpEventReporter.new(@http_url,@sentry_config,@run_status)
        @run_status.events.register(http_event_reporter)
        http_event_reporter.run_started(@run_status)
      end

    end
  end
end
