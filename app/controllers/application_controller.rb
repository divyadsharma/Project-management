class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if (current_user.admin?)
      admin_user_projects_path(current_user)
    else
      user_tasks_path(current_user)
    end
  end
end
