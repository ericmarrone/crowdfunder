class CommentsController < ApplicationController
  before_action :current_user

  def create
    @project = Project.find(params[:project_id])
    @comment = Comment.new
    @comment.title = params[:comment][:title]
    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.project = @project

    if @comment.save
      redirect_to project_url(@project)
    else
      render '/projects/show'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @comment.title = params[:comment][:title]
    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.project = @project

    if @comment.save
      redirect_to project_url(@project)
    else
      render '/projects/show'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "You have successfully deleted the review."
    redirect_to project_url(@project)
  end
end
