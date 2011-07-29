class RolodexController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @contacts = Contact.search(params[:search]).where("user_id = ?", current_user.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    @lists = List.where("user_id = ?", current_user.id)
  end

  private

  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
