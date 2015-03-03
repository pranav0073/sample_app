class Email < ActiveRecord::Base
#	acts_as_audited
	belongs_to :contact
	before_validation :strip_whitespace

	def strip_whitespace
  		self.address = self.address.strip
	end
end
