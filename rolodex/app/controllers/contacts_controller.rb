require 'vpim/vcard'
class ContactsController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @contact.addresses.build
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      @contacts = Contact.search(params[:search]).where("user_id = ?", current_user.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
      flash.now[:notice] = "Successfully created contact."
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      @contacts = Contact.search(params[:search]).where("user_id = ?", current_user.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
      flash.now[:notice] = "Successfully updated contact."
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    @contacts = Contact.search(params[:search]).where("user_id = ?", current_user.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    respond_to do |format|
      format.html{redirect_to "/"}
      format.js {
        render :update do |page|
          page<<"$('#layouts').html('Contact Deleted');"
          page<<"$('#contacts').html('#{ escape_javascript(render("contacts_list"))}');"
        end
      }
    end
    #flash[:notice] = "Successfully destroyed contact."
  end

  def image
		@contact = Contact.find(params[:id])
      if @contact.update_attributes(params[:contact])
        flash.now[:success] = 'La imagen se guardo correctamente.'
      else
        flash.now[:error] = 'Error al subir la imagen.'
      end
	end

  def view
    @contact = Contact.find_by_id(params[:id])
    card = @contact.vcards
    send_data card.to_s, :filename => "contact.vcf"
  end

  def exp_all
    cards=current_user.vcards
    send_data cards.to_s, :filename => "allcontacts.vcf"
  end

  private

  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end