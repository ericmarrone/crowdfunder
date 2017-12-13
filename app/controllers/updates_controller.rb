class UpdatesController < ApplicationController
  def create
    @update = Update.new
    @project = Project.find(params[:project_id])
    @update.title = params[:update][:title]
    @update.content = params[:update][:content]
    @update.user = current_user
    @update.project_id = params[:project_id]

    if @update.save
      flash.now[:success] = "Your update has been added!"
      redirect_to project_path(@project.id)
    else
      flash.now[:alert] = "Sorry, there were issues creating your update."
      render "projects/show"
    end
  end

  def update

  end
end
