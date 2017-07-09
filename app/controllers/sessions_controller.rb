class SessionsController < ApplicationController
  skip_before_filter :require_login
  before_filter :check_for_mobile

  layout "login"
  def new
   
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if (user && user.authenticate(params[:session][:password]))
       if user.activated?
        if(!user.disabled)
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_to root_url
        else
          flash.now[:danger] = 'Account disabled. Contact an organization administrator.'
       
          render 'new'
      end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      
    else
      flash.now[:danger] = 'Invalid email/password combination'
     
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end