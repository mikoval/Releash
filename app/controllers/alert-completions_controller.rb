class AlertCompletionsController < ApplicationController
  skip_before_filter :require_login
  def edit
    @alert = Alert.find_by(id: params[:id])

   
    @alert.update_attribute(:completed, true)
      
    
    redirect_to "/alerts/completed"
    
  end
end