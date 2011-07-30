require 'spec_helper'

describe User do
  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  before(:each) do
    @user = Factory(:user)
  end

  it { should have_many(:contacts) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('jimmybob@gmail.com').for(:email) }
  it { should_not allow_value('jimmybob @gmail.com').for(:email) }
  it { should_not allow_value('jimmybobatgmaildotcom').for(:email) }

  it { should allow_value('password1').for(:password) }
  it { should_not allow_value(nil).for(:password) }
  it { should_not allow_value('').for(:password) }
  it { should_not allow_value('123').for(:password) }


end