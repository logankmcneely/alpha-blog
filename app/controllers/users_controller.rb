class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_user, only: [:show, :edit, :update, :destroy, :likes]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy, :likes]

  def index
    # Returns all users for admin and only users with articles for others
    # Users are returned in the order of articles written
    if (user_signed_in? && current_user.admin?)
      @users = User.left_outer_joins(:articles).group('users.id').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    else 
      @users = User.joins(:articles).group('users.id').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @articles = @user.articles.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def likes
    @articles = @user.liked_articles.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to @user
    end
  end

end
