# Developer Project task
class DeveloperProject < ApplicationRecord

  # associations
  belongs_to :project
  belongs_to :user

end
