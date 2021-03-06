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
require 'digest'
class User < ActiveRecord::Base
	#acts_as_audited :protect => false
	has_one :phonebook
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation

	#Automatically create the virtual attribute , 'password confirmation'
	validates_confirmation_of :password

	#password validations
	validates_presence_of :password
	validates_length_of :password, :within => 6..40

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/is
	validates_presence_of :name, :email
	validates_length_of :name, :maximum =>50
	validates_format_of   :email, :with => EmailRegex
	validates_uniqueness_of :email, :case_sensitive =>false

	before_save :encrypt_password
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def remember_me!
		self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    	save_without_validation
	end
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	private

	 	def encrypt_password
	 			unless password.nil?
	 			self.salt = make_salt
	 			self.encrypted_password = encrypt(password)
	 		end
	 	end

	 	def encrypt(string)
	 		secure_hash("#{salt}#{string}")  #only a temp implementaion
	 	end

	 	def make_salt
	 		secure_hash("#{Time.now.utc}#{password}")
	 	end

	 	def secure_hash(string)
	 		Digest::SHA2.hexdigest(string)
	 	end
end
