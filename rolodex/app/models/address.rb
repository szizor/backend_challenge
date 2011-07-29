class Address < ActiveRecord::Base
  belongs_to :address_type
  belongs_to :contact
  validates_presence_of :address,:city,:state, :contact_id,:address_type_id,:zip
  delegate :name, :to => :address_type, :prefix => true
end
