# frozen_string_literal: true

require 'rails_helper'
describe Api::Instagram::V0::Request do
  describe 'request' do
    let(:client) { Api::Client.new }
    subject { described_class.new.send(:request, client, http_method: :get, endpoint: '/instagram') }

    before do
      stub_request(:get, 'https://takehome.io/instagram')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v1.3.0'
          }
        )
        .to_return(response)
    end

    context 'when response code is 200' do
      let(:body) do
        [{ profilename: 'profilename1', photo: 'photo1' }, { profilename: 'profilename2', photo: 'photo2' }]
      end
      let(:response) { { status: 200, body: body.to_json } }

      it 'returns correct data in response' do
        expect(subject) == body
      end
    end

    context 'when response code is not 200' do
      let(:response) { { status: 404 } }

      it 'returns error message in response' do
        expect { subject }.to raise_error StandardError
      end
    end
  end
end
