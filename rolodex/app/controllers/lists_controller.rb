require 'vpim/vcard'
class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params[:list])
    @lists = List.where("user_id = ?", current_user.id)
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
      @lists = List.where("user_id = ?", current_user.id)
      flash[:notice] = "List Successfully updated."
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:notice] = "List Successfully destroyed."
    redirect_to lists_url
  end

  def export
    @list=List.find(params[:id])
    cards=@list.vcards
    send_data cards.to_s, :filename => "#{@list.name}.vcf"
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
