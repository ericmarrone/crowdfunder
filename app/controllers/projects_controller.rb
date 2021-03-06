class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
  end

  def show
    @project = Project.find(params[:id])
    @user    = @project.user
    @update  = Update.new
    @comment = Comment.new
  end

  def new
    @project = Project.new
    @project.rewards.build
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.user = current_user
    @project.category_id = params[:project][:category]

    if @project.save
      flash[:notice] = "Project created successfully!"
      redirect_to projects_url
    else
      render 'new'
    end
  end

end
