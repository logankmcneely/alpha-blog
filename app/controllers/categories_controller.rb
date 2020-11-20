class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    # Returns all categories for admin and only categories with articles for users
    if (logged_in? && current_user.admin?)
      # Returns categoires in order of number of articles and includes those with no articles 
      @categories = Category.left_outer_joins(:articles).group('categories.name').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    else
      # Returns categories in order of articles written (omits those with no articles)
      @categories = Category.joins(:articles).group('categories.name').order('count(articles.id) DESC').paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:notice] = "You have successfully created the category #{@category.name}"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "#{@category.name}'s was successfully updated."
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "#{@category.name}'s was successfully deleted."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You lack the permissions to perform that action"
      redirect_to categories_path
    end
  end

end
