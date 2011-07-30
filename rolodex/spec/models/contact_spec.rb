require 'spec_helper'

describe Contact do
  before(:each) do
    @contact = Factory(:contact)
  end

  it { should have_many(:contact_lists) }
  it { should have_many(:lists).through(:contact_lists) }
  it { should have_many(:phone_numbers) }
  it { should have_many(:addresses) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_uniqueness_of(:first_name).
                  scoped_to(:last_name) }
  it { should have_many(:phone_numbers) }
  it { should have_many(:addresses) }
  it { should belong_to(:user) }

  

  it "should be able to be deleted" do
    Contact.all.size.should == 1
    @contact.delete
    Contact.all.size.should == 0
  end


end