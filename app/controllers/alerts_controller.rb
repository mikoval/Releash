class AlertsController < ApplicationController
  
  #listing all the alerts
  def list
    @alert = Alert.new
    @alerts = Alert.all
  end

  #for the new alerts
  def new
    @alert = Alert.new
    @types = AlertType.all
    @users = User.all
  end

  #for displaying alerts
  def display
    @alert = Alert.find(params["param"])
  end

  def newAlert
    
    @alert = Alert.new(alert_params)  do |q|
          q.created_by_id = current_user.id
    end

    @allAlerts = Alert.all
    @types = AlertType.all
    @users = User.all
    
    if @alert.save
      flash.now[:success] = "New Alert!"
      redirect_to :controller => "alerts", :action => "list"
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
    params.require(:alert).permit(:title, :description, :date, :alert_type_id, :assignee_id,
                  :created_by_id, :animal_id, :location, :created_at)
  end
  def query
    @id = params["id"]
    if(@id!=nil)
      @alert = Alert.find(@id)
      @str = {"title" => @alert.title, "description" => @alert.description } 
    else
      @alerts = Alert.all
      @str = []
      if (!@alerts.nil?) 
      @alerts.each do |a|
        @str.push({
          "id" =>  a.id, 
          "title" => a.title,
          "description" => a.description,
          "date" => a.date,
        })
      end
    end



    end
    
    render json: @str
  end
end
