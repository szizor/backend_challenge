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
