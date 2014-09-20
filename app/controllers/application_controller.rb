class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  set_current_tenant_by_subdomain(:pool, :subdomain)
  
  before_action :authenticate, :authorize, :check_for_email

  private

  	def check_for_email
  		if signed_in? && current_user.email.blank?
  			redirect_to email_user_path(current_user)
  		end
  	end
end
