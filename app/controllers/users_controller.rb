class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # Returns all categories for admin and only categories with articles for users
    if (logged_in? && current_user.admin?)
      # Returns all users in order of articles written for admin access (even those without any articles)
      @users = User.left_outer_joins(:articles).group('users.id').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    else 
      # Returns users in order of articles written (omits those with no articles)
      @users = User.joins(:articles).group('users.id').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @articles = @user.articles.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    redirect_to root_path
  end

  def link_to "link text...", parent_child_path(@parent, @child)

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :image_url, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only modify your own account"
      redirect_to @user
    end
  end

end
