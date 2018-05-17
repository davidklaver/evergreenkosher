class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def pretty_time
  		created_at.strftime("%b %d, %Y")
	end
end
