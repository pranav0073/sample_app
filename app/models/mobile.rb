class Mobile < ActiveRecord::Base
	#acts_as_audited :on => [:update], :only => [:details]
	track_this_model :only => [:details]
	belongs_to :contact
	before_validation :strip_whitespace

	def strip_whitespace
  		self.details = self.details.strip
	end
end

