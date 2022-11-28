# frozen_string_literal: true

module LikesHelper
  def like_button(likeable:, user:)
    liked_by_user = likeable.liked_by_user
    user_present = user.present?
    like_count = likeable.reactions['likes']
    if liked_by_user
      http_method = :delete
      url = like_path(likeable.id)
    else
      http_method = :post
      url = likes_path(like: { likeable_reference: likeable.id })
    end
    render partial: 'like_button', locals: { likeable:, liked_by_user:, user_present:, like_count:, url:, http_method: }
  end
end
