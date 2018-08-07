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

  #scope
  scope :in_progress, ->(tasks){ tasks.where(status: "in_progress") }
  scope :done, ->(tasks){ tasks.where(status: "done") }
  scope :pending, ->(tasks){ tasks.where(status: "pending") }
end
