class Contact < ActiveRecord::Base
	belongs_to :phonebook
	has_many :mobiles, :dependent =>:destroy
	has_many :emails,  :dependent =>:destroy
	accepts_nested_attributes_for :emails,  :allow_destroy => true, :reject_if => proc { |a| a['address'].blank? }
	accepts_nested_attributes_for :mobiles, :allow_destroy => true, :reject_if => proc { |a| a['details'].blank? }
	validates_presence_of :name
end
