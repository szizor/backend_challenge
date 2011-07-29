class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params[:list])
    if @list.save
    else
      render :action => 'new'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:notice] = "List Successfully updated."
      redirect_to @list
    else
      render :action => 'edit'
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:notice] = "List Successfully destroyed."
    redirect_to lists_url
  end

  def add_contact
    @list = List.find(params[:list])
    @contact=Contact.find(params[:cell])
    @list.contacts<<@contact
    @lists = List.where("user_id = ?", current_user.id)
  end
  def remove_contact
    @list = List.find(params[:list])
    @contact=Contact.find(params[:id])
    @list.contacts.delete(@contact) if @list.contacts(@contact)
    @lists = List.where("user_id = ?", current_user.id)
  end

end
