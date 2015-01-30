class Contact < ActiveRecord::Base
	belongs_to :phonebook
	has_many :mobiles
	has_many :emails
	accepts_nested_attributes_for :mobiles, :emails, :allow_destroy => true
end
