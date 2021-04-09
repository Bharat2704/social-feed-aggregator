# frozen_string_literal: true

class SocialAggregator < ActiveInteraction::Base
  include SocialAggregatorHelper

  def execute
    aggregated_posts = {}
    threads = []
    SOCIAL_HASH.each do |platform, _value|
      threads << Thread.new do
        posts = find_posts(platform)
        aggregated_posts[platform] = posts || 'Error occured'
      end
    end
    threads.each(&:join)
    aggregated_posts
  end

  private

  def find_posts(key)
    Rails.cache.fetch(key, expires_in: 1.minute) do
      cache_posts(fetch_posts(key), key)
    end
  end

  def cache_posts(posts, platform)
    FetchSocialWorker.perform_async(platform) and return nil unless posts

    posts.map { |element| element[SOCIAL_HASH[platform]] }
  end
end
