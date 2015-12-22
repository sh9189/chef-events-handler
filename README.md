# event-reporting-handler

Chef handler to send chef run events to a http url. Also reports chef run failures to sentry.

## Usage

StartHandler class requires two arguments to construct an object, a http url to send chef run events and a sentry config. The sentry config is a hash that should atleast include sentry dsn to send messages on a chef run failure.

The simplest way to use 'event-reporting-handler' is by adding 'event-reporting-handler' as start handler using [chef client cookbook](https://github.com/chef-cookbooks/chef-client).
 For example,
```ruby
node.default['chef_client']['load_gems']['sentry-raven'] = {
    :version => '0.9.4'
}
node.default['chef_client']['load_gems']['event-reporting-handler'] = {
    :require_name => 'event_reporting_handler',
    :version => '0.1.11'
}

node.default['chef_client']['config']['start_handlers'] = [
    {
        :class => "BloombergLP::EventReportingHandler::StartHandler",
        :arguments => [ some_http_url, {dsn: some_sentry_dsn }]
    }
]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sh9189/chef-events-handler.

## Acknowledgements

Heavily borrows work done under https://github.com/coderanger/chef-sentry-handler for sending chef run failures to sentry

## License

Copyright 2015, Bloomberg Finance L.P.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
