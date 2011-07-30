require 'spec_helper'
describe List do
  before(:each) do
    @contact = Factory(:list)
  end
    it { should have_many(:contact_lists) }
    it { should have_many(:contacts).through(:contact_lists) }
    it { should validate_presence_of(:name) }
end
