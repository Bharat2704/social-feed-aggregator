module SocialAggregatorHelper
  SOCIAL_HASH = {
    facebook: 'status',
    instagram: 'photo',
    twitter: 'tweet'
  }

  def fetch_posts(platform)
    response = api_call(platform)
    response.success? ? response.data : nil
  end

  def api_call(platform)
    "Api::#{platform.to_s.capitalize}::V0::Request".constantize.call
  end
end
