class LikesController < ApplicationController
  def create
    article_id = params.fetch(:article_id)

    Like.create!(article_id:)

    redirect_to root_path
  end
end
