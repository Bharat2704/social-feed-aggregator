# frozen_string_literal: true

require 'rails_helper'
describe Api::Twitter::V0::Request do
  describe 'request' do
    let(:client) { Api::Twitter::V0::Client.new }
    subject { described_class.new.send(:request, client, http_method: :get, endpoint: '/twitter') }

    before do
      stub_request(:get, 'https://takehome.io/twitter')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Faraday v1.3.0' })
        .to_return(response)
    end

    context 'when response code is 200' do
      let(:body) { [{ username: 'username1', tweet: 'tweet1' }, { username: 'username2', tweet: 'tweet2' }] }
      let(:response) { { status: 200, body: body.to_json } }

      it 'returns correct data in response' do
        expect(subject) == body
      end
    end

    context 'when response code is not 200' do
      let(:response) { { status: 404 } }

      it 'returns error message in response' do
        expect { subject }.to raise_error Api::ApiExceptions::NotFoundError
      end
    end
  end
end
