require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  require 'spec_helper'

  describe User do

    before(:each) do
      @attr = { 
        :email => "user@example.com",
        :password => "password",
        :password_confirmation => "password"
      }
    end
    
    describe "email validations" do

      it "should require an email" do
        no_email_user = User.new(@attr.merge(:email => ""))
        no_email_user.should_not be_valid
      end

      it "should reject duplicate emails" do
        User.create!(@attr)
        user2 = User.new(@attr.merge(:username => "example2"))
        user2.should_not be_valid
      end

      it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = User.new(@attr.merge(:email => address))
          valid_email_user.should be_valid
        end
      end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(:email => address))
          invalid_email_user.should_not be_valid
        end
      end

      it "should reject email address idential up to case" do
        User.create!(@attr)
        user = User.new(@attr.merge(:email => @attr[:email].capitalize))
        user.should_not be_valid
      end

    end



    describe "password validations" do

      it "should require a password or a password confirmation" do
        user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
        user.should_not be_valid
      end

      it "should require a password" do
        user = User.new(@attr.merge(:password => ""))
        user.should_not be_valid
      end

      it "should require a password confirmation" do
        user = User.new(@attr.merge(:password_confirmation => ""))
        user.should_not be_valid
      end

      it "should require a matching password confirmation" do
        user = User.new(@attr.merge(:password_confirmation => "invalid"))
        user.should_not be_valid
      end

      it "should reject passwords that are too short" do
        password = "a" * 5
        user = User.new(@attr.merge(:password => password, :password_confirmation => password))
        user.should_not be_valid
      end

      it "should reject passwords that are too long" do
        password = "a" * 41
        user = User.new(@attr.merge(:password => password, :password_confirmation => password))
        user.should_not be_valid
      end

      it "should require case sensative password confirmations" do
        password = "password"
        user = User.new(@attr.merge(:password => password,
            :password_confirmation => password.capitalize))
        user.should_not be_valid
      end

    end

  end


end
