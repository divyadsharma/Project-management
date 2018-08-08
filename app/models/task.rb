 # Todo Tasks
class Task < ApplicationRecord

  # associations
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  # validations
  validates :title, :description, presence: true

  # setting enum
  enum status: [:pending, :in_progress, :done]

  # scope
  scope :in_progress, ->(tasks) { tasks.where(status: 'in_progress') }
  scope :done, ->(tasks) { tasks.where(status: 'done') }
  scope :pending, ->(tasks) { tasks.where(status: 'pending') }
  scope :projects, ->(project_id) { where(project_id: project_id) }

  def self.pie_data(tasks)
    [['Task', 'task count'],
     ['In Progress', in_progress(tasks).count],
     ['Pending', pending(tasks).count],
     ['Done', done(tasks).count]]
  end
end
