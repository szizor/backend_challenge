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

  it { should allow_value('55416').for(:zip) }
  it { should allow_value('55416-6789').for(:zip) }
  it { should_not allow_value('554316').for(:zip) }
  it { should_not allow_value('554s6').for(:zip) }
  it { should_not allow_value('5 416').for(:zip) }
  it { should_not allow_value('554166789').for(:zip) }
  it { should_not allow_value('55416-67892').for(:zip) }
  it { should_not allow_value(' 55416 ').for(:zip) }

  it "should delegate address_type_name to address type" do
    address_type = Factory(:address_type, :name => 'home')
    @address.address_type = address_type
    @address.address_type_name.should == 'home'
  end

end
