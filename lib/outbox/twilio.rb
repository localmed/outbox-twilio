require 'outbox'

module Outbox
  module Twilio
    require 'outbox/twilio/version'
    require 'outbox/twilio/client'
  end

  Messages::SMS.register_client_alias(:twilio, Outbox::Twilio::Client)
end
