# Project Tasks
class Project < ApplicationRecord

  # associations
  has_many :tasks
  has_many :developer_projects
  has_many :users, through: :developer_projects
  # , foreign_key: 'user_id'

  # nested attributes
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :developer_projects
  # , :allow_destroy => :false, 


  # validations
  validates :title, :description, presence: true

  # setting enum
  enum status: [:pending, :in_progress, :done]
end
