# Todo Tasks
class Task < ApplicationRecord

  # associations
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  # nested attributes
  # accepts_nested_attributes_for :user
  # accepts_nested_attributes_for :project

  # validations
  validates :title, :description, presence: true

  # setting enum
  enum status: [:pending, :in_progress, :done]
end
