class List < ActiveRecord::Base
  attr_accessible :name,:user_id

  belongs_to :user
  has_many :contact_lists
  has_many :contacts, :through => :contact_lists

  validates_presence_of :name

  def self.search(search)
    if search
      where('first_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
