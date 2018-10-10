class RepositoriesController < ApplicationController

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(repository_params)
    @repository.create_link(params[:repository][:link])
    if @repository.save
      redirect_to repository_path(@repository.id)
    else
      render 'new'
    end
  end

  def show
    @repository = Repository.find(params[:id])
    @contributors = @repository.contributors
  end

  private

  def repository_params
    params.require(:repository).permit(:link)
  end
end