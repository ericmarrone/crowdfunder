class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @projects = Project.all
  end

  def show
    @category = Category.find(params[:id])
  end

end
