class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: { success: false, status: 403, message: 'Not Permitted for this action' } }
      format.xml  { render xml: '...', status: 403, message: exception.message }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end
end
