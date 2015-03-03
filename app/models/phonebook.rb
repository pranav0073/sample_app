class Phonebook < ActiveRecord::Base
	#acts_as_audited
	belongs_to :user
	has_many :contacts, :dependent =>:destroy 
	accepts_nested_attributes_for :contacts, :allow_destroy => true
end
