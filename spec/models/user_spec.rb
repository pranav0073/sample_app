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
      :email => "pranav0073@gmail.com"
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
end
