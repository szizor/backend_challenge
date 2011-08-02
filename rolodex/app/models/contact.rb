class Contact < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name,:user_id, :addresses_attributes,:phone_numbers_attributes,:photo
  has_attached_file :photo,
     :styles => {
       :thumb=> "100x100#",
       :small  => "400x400>" }
  has_many :phone_numbers,:dependent=>:destroy
  has_many :addresses,:dependent=>:destroy
  has_many :contact_lists
  has_many :lists, :through => :contact_lists
  belongs_to :user
  accepts_nested_attributes_for :phone_numbers,:addresses

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :first_name, :uniqueness => {:scope => :last_name}


  # add a self to a list
  def add_to_list(list)

  end

  def vcards
    card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_photo do |photo|
        photo.image = "File.open('#{self.photo.url(:thumb)}').read # a fake string, real data is too large :-)"
        photo.type = 'jpeg'
      end if self.photo
      maker.add_name do |name|
        name.prefix = ''
        name.given = self.first_name
        name.family = self.last_name
      end
      for address in self.addresses
        maker.add_addr do |addr|
          #addr.preferred = true
          addr.location = address.address_type.name if address.address_type
          addr.street = address.address if address.address
          addr.locality = address.city if address.city
          addr.country = address.country if address.country
        end
      end

      for phone in self.phone_numbers
        maker.add_tel(phone.full_number)
      end

    end
    card.to_s
  end

   def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def self.search(search)
    if search
      where('first_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
