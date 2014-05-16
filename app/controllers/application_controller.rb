class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:signin)}
	  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email,
	                                                         :username, :password, :password_confirmation)}
  end
  layout :layout_by_resource

  protected
  def layout_by_resource
	  if devise_controller?
		  if resource_name == :admin
			  "devise_admin_application" #admin model will use this layout
		  elsif resource_name == :employee
			  "devise_employee_application" #employee model will use this

		  else
			  "devise_application" #other devise model will use this

		  end
	  else
		  "application" #default rails application layout
	  end
  end
end
