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
    case platform
    when :facebook
      Api::Facebook::V0::Request.new.call
    when :twitter
      Api::Twitter::V0::Request.new.call
    else
      Api::Instagram::V0::Request.new.call
    end
  end
end
