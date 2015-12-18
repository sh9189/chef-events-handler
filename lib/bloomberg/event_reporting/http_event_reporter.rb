# License: Apache 2.0
#
# Copyright 2015, Noah Kantrowitz
# Copyright 2015, Bloomberg Finance L.P.
#
require 'chef/event_dispatch/base'
module Bloomberg
  module EventReporting
    class HttpEventReporter < Chef::EventDispatch::Base



       def initialize(url)
         @url = url
       end

       def run_started(run_status)
         @chef_run_id = run_status.run_id

       end


       # Called at the end a successful Chef run.
      def run_completed(node)
      end

      # Called at the end of a failed Chef run.
      def run_failed(exception)

      end

      private
      def publish_event(event)
        json_to_publish = get_json_from_event(event)
        uri = URI(url)
        res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.post(uri.path, json_to_publish, 'Content-Type' => 'application/json')
        end
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          Chef::Log.debug("Successfully sent http request with #{json_to_publish}")
        else
          Chef::Log.warn("Error in sending http request to #{url} Code is #{res.code} Msg is #{res.message}")
        end
      end

      def get_json_from_event(name, event)
        { deploy_event: { node_fqdn: name, sub_type: event, occurred_at: Time.now.to_s } }.to_json
      end


    end
  end
end
