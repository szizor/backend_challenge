class Address < ActiveRecord::Base
  belongs_to :address_type
  belongs_to :contact

  accepts_nested_attributes_for :contact
  #validates_presence_of :address, :zip, :city, :state, :contact_id, :address_type_id
  #validates_format_of :zip, :with => /^[0-9]{5}(-[0-9]{4})?$/
  delegate :name, :to => :address_type, :prefix => true
end
