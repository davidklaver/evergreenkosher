class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def pretty_time
  		created_at.strftime("%b %d, %Y")
	end

	def detailed_pretty_time
  		created_at.strftime("%-I:%M%p, %b %d, %Y")
	end
end
