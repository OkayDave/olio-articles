# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :require_login

  def create
    likeable_reference = like_params[:likeable_reference]
    Like.find_or_create_by(user: current_user, likeable_reference:)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(likeable_reference: params[:id], user: current_user)
    @like&.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_reference)
  end
end
