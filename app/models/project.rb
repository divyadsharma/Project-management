# Project Tasks
class Project < ApplicationRecord

  # associations
  has_many :tasks
  has_many :developer_projects
  has_many :users, through: :developer_projects

  # nested attributes
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :developer_projects

  # validations
  validates :title, :description, presence: true

  # scopes
  scope :title, ->(project_id) { find_by_id(project_id).title }
end
