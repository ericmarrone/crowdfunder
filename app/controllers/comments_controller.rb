class CommentsController < ApplicationController
  before_action :current_user

  def create
    @project = Project.find(params[:id])
    @comment = Comment.new
    @comment.title = params[:comment][:title]
    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.project = @project
  end

  def update
  end

  def destroy
  end
end
