# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'chef/event_dispatch/base'
module EventReportingHandler
  class HttpEventReporter < Chef::EventDispatch::Base

     def initialize(http_url)
       @http_url = http_url
     end

     def run_started(run_status)
       @chef_run_id = run_status.run_id
       @node_fqdn = run_status.node.name
       publish_event(:run_started)
     end


     # Called at the end a successful Chef run.
    def run_completed(node)
      publish_event(:run_completed)
    end

    # Called at the end of a failed Chef run.
    def run_failed(exception)
      publish_event(:run_failed)
    end

    private
    def publish_event(event)
      json_to_publish = get_json_from_event(event)
      uri = URI(@http_url)
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

    def get_json_from_event(event)
      { deploy_event: { node_fqdn: @node_fqdn, sub_type: event, occurred_at: Time.now.to_s } }.to_json
    end


  end
end
