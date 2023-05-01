class LikesController < ApplicationController
  def create
    article_id = params.fetch(:article_id)

    Like.create!(article_id:)

    respond_to do |format|
      format.json { render json: json_response_body(article_id) }
      format.html { redirect_to root_path }
    end
  end

  private

  def json_response_body(article_id)
    {
      article_id:,
      likes: ActiveSupport::NumberHelper.number_to_delimited(Like.count_for(article_id))
    }
  end
end
