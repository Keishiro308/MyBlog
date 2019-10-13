class ApplicationController < ActionController::Base
  before_action :set_search_post
  PER=8

  private
  def set_search_post
    @q = Post.ransack(params[:q])
    @search_posts = @q.result.includes(:tags).page(params[:page]).per(PER).order(created_at: "DESC")
  end
end
