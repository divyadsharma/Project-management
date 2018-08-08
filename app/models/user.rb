class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associations
  has_many :developer_projects
  has_many :projects, through: :developer_projects
  has_many :tasks

  def admin?
    self.type == 'Admin'
  end

  def developer?
    self.type == 'Developer'
  end
end
