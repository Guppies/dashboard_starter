class VisitorsController < ApplicationController
  layout 'visitors'

  def home
    redirect_to current_user.present? ? dashboard_path : new_user_session_path
  end
end
