Outbox::Twilio
==============

[![Gem Version](https://badge.fury.io/rb/outbox-twilio.png)](http://badge.fury.io/rb/outbox-twilio)

Twilio SMS client wrapper for [Outbox](https://github.com/localmed/outbox).

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'outbox-twilio'
```

And then execute:

``` bash
$ bundle
```

Or install it yourself as:

``` bash
$ gem install outbox-twilio
```

## Usage

Configure Outbox to use Outbox::Twilio as the default SMS client:

``` ruby
Outbox::Messages::SMS.default_client(
  :twilio,
  account_sid: 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  auth_token: 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
  # Supports other Twilio::REST::Client options:
  timeout: 30,
  retry_limit: 1
)
```

SMS messages will now use the Twilio API for devlivery:

``` ruby
sms = Outbox::Messages::SMS.new(
  from: '+15551115555',
  body: 'Hello World',
  # supports Twilio's non-standard parameters:
  media_url: 'https://www.example.com/hearts.png'
)
sms.deliver('+15552224444')
```

## Contributing

1. Fork it ( https://github.com/localmed/outbox-twilio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
