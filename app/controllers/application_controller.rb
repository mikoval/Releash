class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def resolve_layout
    if mobile_device?
      "mobile"
    else
      "application"
    end
  end
  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]

    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile

    prepend_view_path Rails.root + 'app' + 'mobile_views'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
        (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)    end
  end
  helper_method :mobile_device?



  include SessionsHelper
  protect_from_forgery with: :exception

  
  before_filter :require_login

  def getAge(date)
    return ((Time.now.to_i  - date.to_datetime.to_i )  / 1.year).to_i
  end
private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
  def date_format(date)
    return date.to_formatted_s(:long_ordinal)
  end
end
