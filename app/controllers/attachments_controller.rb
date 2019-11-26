class AttachmentsController < ApplicationController

  # before_action :authenticate_user!,:except => [:show]
  # before_action :prevent_user_forgery, :only => [:edit,:update,:delete,:destroy]

  def index
    @attachments = current_user.attachments
  end

  def show
    # this is gonna be for showing a download link
    # get it and show it if user allowed it to be seen only
    # @attachment = Attachment.find(params[:id])
  end

  def new
    @attachment = current_user.attachments.build
  end

  def create
    @attachment = current_user.attachments.build(attachment_params)

    if @attachment.save
      flash[:notice] = "Success! Attachment created"
      redirect_to attachments_path
    else
      render('new')
    end
  end

  # edit will be removed in future, maybe change name of the file?
  def edit
    @attachment = Attachment.find(params[:id])
    if !@authoriy_provided
      redirect_to :controller => 'attachment',:action => 'index'
    end
  end

  # edit will be removed in future, maybe change name of the file?
  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update(attachment_params)
      flash[:notice] = "Success! Attachment updated"
      redirect_to attachments_path
    else
      render('edit')
    end
  end

  # if you don't use delete view this is also useless because this is GET request
  def delete
    @attachment = Attachment.find(params[:id])
    if !@authoriy_provided
      redirect_to attachments_path
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    flash[:notice] = "Success! Attachment destroyed"
    redirect_to attachments_path
  end

  private
  def attachment_params
    params.require(:attachment).permit(:name, :file)
  end

  def prevent_user_forgery
    @attachment = Attachment.find(params[:id])
    if @attachment.user_id != current_user.id
      @authority_provided = false
      redirect_to :controller => 'application', :action => 'home'
    else
      @authority_provided = true
    end
  end

  def inc_download_count
    @attachment = Attachment.find(params[:id])
    @attachment.download_count += 1
    @attachment.save
  end

end