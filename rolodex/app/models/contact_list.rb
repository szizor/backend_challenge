class ContactList < ActiveRecord::Base
  belongs_to :contact
  belongs_to :list
end
