# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "pranav",
      :email => "pranav0073@gmail.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should reqire a name" do
  	no_name_user = User.new(@valid_attributes.merge(:name => ""))
  	no_name_user.should_not be_valid
  end

  it "should require an email adress" do 
  	no_email_user = User.new(@valid_attributes.merge(:email => ""))
  	no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
  	long_name = "a" * 51
  	long_name_user = User.new(@valid_attributes.merge(:name => long_name))
  	long_name_user.should_not be_valid
  end

  it "should accept a valid email address" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
	  addresses.each do |address|
		  valid_email_user = User.new(@valid_attributes.merge(:email => address))
		  valid_email_user.should be_valid
		end
	end
	
  it "should reject invalid email address" do
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@valid_attributes.merge(:email => address))
      invalid_email_user.should_not be_valid
		end
	end

	it "should not have a duplicate email address" do
		#put a user with given email address into the database
		User.create!(@valid_attributes)
		user_with_duplicate_email = User.new(@valid_attributes)
		user_with_duplicate_email.should_not be_valid
	end

	it "should reject the email address identical up to case" do
		upcase_email = @valid_attributes[:email].upcase
		User.create!(@valid_attributes.merge(:email => upcase_email))
		user_with_duplicate_email = User.new(@valid_attributes)
		user_with_duplicate_email.should_not be_valid
	end

  describe "password validations" do
    it "should require a password" do
      User.new(@valid_attributes.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end

    it "should require a matching password" do
      User.new(@valid_attributes.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @valid_attributes.merge(:password => short, :password_confirmation =>short)
      User.new(hash).should_not be_valid
    end

    it "should reject the long passwords" do
      long = "a" *41
      hash = @valid_attributes.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@valid_attributes[:password]).should be_true
      end

      it "should be false if the password dont match" do
        @user.has_password?("invalid").should be_false
      end
    end
    describe "authentication method" do
      it "should return nil on email/password mismatch" do
        wrong_pass_user = User.authenticate(@valid_attributes[:email], "wrongpass")
        wrong_pass_user.should be_nil
      end

      it "should return nil for an email adrees with no user" do
        nonexistent_user = User.authenticate("pd0073@gmail.com",@valid_attributes[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/pass match" do
        matching_user = User.authenticate(@valid_attributes[:email],@valid_attributes[:password])
        matching_user.should == @user
      end
    end
  end

  describe "remember me" do
    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should have a remember token" do
      @user.should respond_to(:remember_token)
    end

    it "should have a remember_me token" do
      @user.should respond_to(:remember_me!)
    end

    it "should set the remember token" do
      @user.remember_me!
      @user.remember_token.should_not be_nil
    end
  end
end







