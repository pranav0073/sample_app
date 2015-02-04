class Contact < ActiveRecord::Base
	belongs_to :phonebook
	has_many :mobiles, :dependent =>:destroy
	has_many :emails,  :dependent =>:destroy
	has_many :other_connections,:dependent => :destroy
	accepts_nested_attributes_for :emails,  :allow_destroy => true, :reject_if => proc { |a| a['address'].blank? }
	accepts_nested_attributes_for :mobiles, :allow_destroy => true, :reject_if => proc { |a| a['details'].blank? }
	accepts_nested_attributes_for :other_connections, :allow_destroy => true, :reject_if => proc { |a| a['connection_type'].blank? || a['connection_detail'] }

	validates_presence_of :name
	before_validation :strip_whitespace

	def strip_whitespace
  		self.name = self.name.strip
  		self.fb = self.fb.strip
  		self.twitter = self.twitter.strip
  		self.github = self.github.strip
  		self.google_plus = self.google_plus.strip
  		
	end
end
