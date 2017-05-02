require 'twilio-ruby'

module Outbox
  module Twilio
    # Uses Twilio's official Ruby API client (twilio-ruby) to deliver
    # SMS messages.
    #
    #   Outbox::Messages::SMS.default_client(
    #     :twilio,
    #     account_sid: 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    #     auth_token: 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
    #   )
    #   sms = Outbox::Messages::SMS.new(
    #     from: '+15551115555',
    #     body: 'Hello World'
    #   )
    #   sms.deliver('+15552224444')
    class Client < Outbox::Clients::Base
      attr_reader :api_client

      def initialize(settings = nil)
        super

        options = @settings.dup
        @api_client = ::Twilio::REST::Client.new(
          options[:username] || options[:account_sid],
          options[:password] || options[:auth_token],
          options[:account_sid]
        )
      end

      def deliver(sms)
        params = {
          from: sms.from,
          to: sms.to,
          body: sms.body,
          media_url: sms[:media_url],
          status_callback: sms[:status_callback],
          application_sid: sms[:application_sid]
        }
        params.delete_if { |_, value| value.nil? }
        @api_client.api.account.messages.create(params)
      end
    end
  end
end
