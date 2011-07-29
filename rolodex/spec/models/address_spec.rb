require 'spec_helper'

describe Address do
  before(:each) do
    @address = Factory(:address)
  end

  it { should belong_to(:contact) }
  it { should belong_to(:address_type) }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:contact_id) }
  it { should validate_presence_of(:address_type_id) }


  it "should delegate address_type_name to address type" do
    address_type = Factory(:address_type, :name => 'home')
    @address = Factory(:address, :address_type => address_type )
    @address.address_type = address_type
    @address.address_type_name.should == 'home'
  end
end
