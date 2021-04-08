class FetchSocialWorker
  include Sidekiq::Worker
  include SocialAggregatorHelper
  sidekiq_options retry: false

  def perform(platform)
    cache_posts(fetch_posts(platform), platform)
  end

  def cache_posts(posts, platform)
    if posts
      Rails.cache.fetch(platform, expires_in: 1.minute) do
        posts.map { |element| element[SOCIAL_HASH[platform]] }
      end
    end
  end
end
