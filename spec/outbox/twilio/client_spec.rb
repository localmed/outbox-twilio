require 'spec_helper'

describe Outbox::Twilio::Client do
  describe '.new' do
    it 'configures the Twilio API client' do
      api_client = double(:api_client)
      expect(::Twilio::REST::Client).to receive(:new).with(
        'AC1',
        'abcdef',
        'AC1',
        nil
      ).and_return(api_client)
      client = Outbox::Twilio::Client.new(
        account_sid: 'AC1',
        auth_token: 'abcdef'
      )
      expect(client.api_client).to be(api_client)
    end

    context 'with username and password' do
      it 'configures the Twilio API client' do
        api_client = double(:api_client)
        expect(::Twilio::REST::Client).to receive(:new).with(
          'username',
          'abcdef',
          'AC1',
          nil
        ).and_return(api_client)
        client = Outbox::Twilio::Client.new(
          username: 'username',
          password: 'abcdef',
          account_sid: 'AC1'
        )
        expect(client.api_client).to be(api_client)
      end
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
      message_context = double(:message_context)
      expect(message_context).to receive(:fetch)
      expect(@client.api_client.account.messages).to receive(:create).with(
        to: '+14155551212',
        from: 'Company Name',
        body: 'Hello world.',
        media_url: 'http://www.example.com/hearts.png',
        status_callback: 'http://www.example.com/callback',
        application_sid: '1234'
      ).and_return(message_context)
      @client.deliver(@sms)
    end
  end
end
