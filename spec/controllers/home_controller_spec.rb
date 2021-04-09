# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :controller do
  describe 'GET index' do
    before do
      expect_any_instance_of(SocialAggregator).to receive(:execute).once.and_return(aggregator_response)
      get :index
    end

    context 'when result is success' do
      let(:result) do
        {
          twitter: %w[tweet1 tweet2],
          facebook: %w[status1 status2],
          instagram: %w[photo1 photo2]
        }
      end
      let(:aggregator_response) do
        s = SocialAggregator.new
        s.result = result
      end

      it 'returns fetched data' do
        expect(response.body).to eq result.to_json
      end

      it 'responds with 200' do
        expect(response.code).to eq '200'
      end
    end
  end
end
