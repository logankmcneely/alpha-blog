class ArticlesController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    # If user signed in, find out if there is a like association between the
    # current user and the shown article.
    if user_signed_in?
      @user_liked_id = @article.liked_by_user?(current_user.id)
    end
  end

  def index
    # Articles index shows all articles in order of most recently created
    @articles = Article.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def new
    @article = Article.new()
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      # On article create, have the user's creator auto-like their own article
      Like.create(article_id: @article.id, user_id: @article.user.id)
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def like
    # Toggles like status. If like already exists, delete it, else create a new like
    like_status = Article.find(params[:article_id]).liked_by_user?(params[:user_id])
    if like_status
      Like.find(like_status).destroy
    else
      Like.create(article_id: params[:article_id], user_id: params[:user_id])
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :image_url, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only modify your own articles"
      redirect_to @article
    end
  end
end
