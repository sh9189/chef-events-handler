# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

require 'chef/handler'
module EventReporting
  class StartHandler < Chef::Handler
    attr_reader :http_url

    def initialize(http_url)
      @http_url = http_url
    end

    def report
      http_event_reporter = HttpEventReporter.new(http_url)
      @run_status.events.register(http_event_reporter)
      http_event_reporter.run_started(@run_status)
    end

  end
end
