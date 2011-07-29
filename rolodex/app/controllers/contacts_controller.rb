require 'vpim/vcard'
class ContactsController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  def index
    if params[:destroy]=="i"
      logger.info("entro")
      Contact.delete(params[:contacts_ids])
    end
    @contacts = Contact.search(params[:search]).where("user_id = ?", current_user.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end

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
    else
      render :action => 'new'
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
    else
      render :action => 'edit'
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
    card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_photo do |photo|
        photo.image = "File.open('#{@contact.photo.url(:thumb)}').read # a fake string, real data is too large :-)"
        photo.type = 'jpeg'
      end
      maker.add_name do |name|
        name.prefix = ''
        name.given = @contact.first_name
        name.family = @contact.last_name
      end
      for address in @contact.addresses
        maker.add_addr do |addr|
          #addr.preferred = true
          addr.location = address.address_type.name if address.address_type
          addr.street = address.address
          addr.locality = address.city
          addr.country = address.country
        end
      end

      for phone in @contact.phone_numbers
        maker.add_tel(phone.full_number) 
      end
      
    end
    send_data card.to_s, :filename => "contact.vcf"
  end
  private

  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end