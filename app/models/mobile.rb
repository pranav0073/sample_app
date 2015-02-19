class Mobile < ActiveRecord::Base
	acts_as_audited
	belongs_to :contact
	before_validation :strip_whitespace

	def strip_whitespace
  		self.details = self.details.strip
	end
end
