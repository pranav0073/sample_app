class OtherConnection < ActiveRecord::Base
	before_validation :strip_whitespace

	def strip_whitespace
  		self.connection_type = self.connection_type.strip
  		self.connection_detail = self.connection_detail.strip

	end
end
