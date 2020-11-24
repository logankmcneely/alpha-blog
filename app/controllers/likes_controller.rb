class LikesController < ApplicationController

  def create
    @like = Like.new(article_id: params[:article_id], user_id: params[:user_id])
    @like.save
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end
  
end
