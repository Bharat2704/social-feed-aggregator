# frozen_string_literal: true

require 'rails_helper'

describe Api::Client do
  describe 'call' do
    subject { described_class.new.call }

    it 'returns correct x`<Faraday::Connection object' do
      expect(subject).is_a? Faraday::Connection
    end
  end
end
