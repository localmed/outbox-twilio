require 'spec_helper'

describe Outbox::Twilio::Client do
  describe '.new' do
    it 'configures the Twilio API client' do
      api_client = double(:api_client)
      expect(::Twilio::REST::Client).to receive(:new).with(
        'AC1',
        'abcdef',
        timeout: 5,
        retry_limit: 2
      ).and_return(api_client)
      client = Outbox::Twilio::Client.new(
        account_sid: 'AC1',
        auth_token: 'abcdef',
        timeout: 5,
        retry_limit: 2
      )
      expect(client.api_client).to be(api_client)
    end
  end

  describe '#deliver' do
    before do
      @client = Outbox::Twilio::Client.new(
        account_sid: 'AC1',
        auth_token: 'abcdef'
      )
      @sms = Outbox::Messages::SMS.new do
        to '+14155551212'
        from 'Company Name'
        body 'Hello world.'
      end
      @sms[:media_url] = 'http://www.example.com/hearts.png'
      @sms[:status_callback] = 'http://www.example.com/callback'
      @sms[:application_sid] = '1234'
    end

    it 'delivers the SMS' do
      expect(@client.api_client.account.messages).to receive(:create).with(
        to: '+14155551212',
        from: 'Company Name',
        body: 'Hello world.',
        media_url: 'http://www.example.com/hearts.png',
        status_callback: 'http://www.example.com/callback',
        application_sid: '1234'
      )
      @client.deliver(@sms)
    end
  end
end
