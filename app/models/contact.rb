class Contact < ActiveRecord::Base
	belongs_to :phonebook
	has_many :mobiles, :dependent =>:destroy
	has_many :emails,  :dependent =>:destroy
	accepts_nested_attributes_for :mobiles, :emails, :allow_destroy => true
end
