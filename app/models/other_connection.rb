class OtherConnection < ActiveRecord::Base
	#acts_as_audited
	before_validation :strip_whitespace
	validates_presence_of :connection_type, :connection_detail

	def strip_whitespace
  		self.connection_type = self.connection_type.strip
  		self.connection_detail = self.connection_detail.strip

	end
end
