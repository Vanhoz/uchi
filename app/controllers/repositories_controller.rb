class RepositoriesController < ApplicationController
  require 'zip'

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(repository_params)
    @repository.create_link(params[:repository][:link])
    rep = @repository.create_or_show
    if !rep
      if @repository.save
        redirect_to repository_path(@repository.id)
      else
        redirect_to root_path, flash: {error: @repository.errors.full_messages.join(', ')}
      end
    else
      redirect_to repository_path(rep)
    end
  end

  def show
    @repository = Repository.find(params[:id])
    @contributors = @repository.contributors
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ContributorPdf.new(params[:contributor_name], params[:contributor_place], params[:contributions])
  
        send_data pdf.render,
          filename: "repository_#{@repository.id}",
          type: 'application/pdf',
          disposition: 'inline'
      end
      format.zip do
        compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          @contributors.each do |contributor|
            pdf = ContributorPdf.new(contributor.name, contributor.place, contributor.quantity)
            zos.put_next_entry "#{contributor.name}_award.pdf"
            zos.print pdf.render
          end
        end
        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "contributors.zip"
      end
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:link)
  end
end