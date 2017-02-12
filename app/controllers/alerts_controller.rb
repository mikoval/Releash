class AlertsController < ApplicationController
  
  #listing all the alerts
  def list
    @alert = Alert.new
    @allAlerts = Alert.all
  end

  #for the new alerts
  def new
    @alert = Alert.new
    @types = Type.all
    @users = User.all
  end

  #for displaying alerts
  def display
    @alert = Alert.find(params["param"])
  end

  def newAlert
    @alert = Alert.new(alert_params)
    @allAlerts = Alert.all
    @type = Type.all
    
    if @alert.save
      flash.now[:success] = "New Alert!"
      redirect_to :controller => "alert", :action => "display", :param => @alert
    else
      flash.now[:danger] = "Error adding Alert!"
      render 'new'
    end
  end

  def editAlert
    @alert = Alert.find(params["format"])
    if @alert.update_attributes(alert_params)
      flash[:success] = "Created Alert"
      redirect_to :controller => "alerts", :action => "display", :param => @alert
    else
      flash.now[:danger] = "Error creating alert"
      @type = Type.all
      render 'edit'
    end
  end

  def alert_params
    params.require(:alert).permit(:title, :description, :date, :type, :assignee,
                  :created_by, :animal_id, :location, :created_at)
  end
end
