module TrendsHelper

  module Type
    FLUX_REFER = "flux_refer"
    FLUX_LIKE = "flux_like"
    FLUX_COMMENT_REFER = "flux_comment_refer"
    FLUX_COMMENT_REPLY = "flux_comment_reply"
    FLUX_COMMENT_THUMBS = "flux_comment_thumbs"

    FOLLOW = "follow"
  end

  def createTrends(to_user_id, type, refer)
    from_user = current_user()
    return if from_user.id == to_user_id

    trend = Trend.new({
      from_user_id: from_user.id,
      trends_type: type,
      to_user_id: to_user_id
    })

    content = ""

    case type
      # flux
      when TrendsHelper::Type::FLUX_REFER
        trend.flux = refer
        content = "#{from_user.name}在状态里提到了你"
      when TrendsHelper::Type::FLUX_LIKE
        trend.flux = refer
        content = "#{from_user.name}喜欢了你的状态"
      when TrendsHelper::Type::FLUX_COMMENT_REFER
        trend.flux = refer
        content = "#{from_user.name}在评论里提到了你"
      when TrendsHelper::Type::FLUX_COMMENT_REPLY
        trend.flux = refer
        content = "#{from_user.name}回复了你"
      when TrendsHelper::Type::FLUX_COMMENT_THUMBS
        trend.flux = refer
        content = "#{from_user.name}赞了你的评论"

      # relationship
      when TrendsHelper::Type::FOLLOW
        content = "#{from_user.name}关注了你"
    end

    trend.content = content
    trend.save

  end
end
