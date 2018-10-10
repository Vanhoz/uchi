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
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ContributorPdf.new(params[:contributor_name], params[:contributor_place], params[:contributions],)
  
        send_data pdf.render,
          filename: "repository_#{@repository.id}",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:link)
  end
end