class Phonebook < ActiveRecord::Base
	belongs_to :user
	has_many :contacts, :dependent =>:destroy 
	accepts_nested_attributes_for :contacts, :allow_destroy => true
end
