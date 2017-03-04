class AlertsController < ApplicationController
  def date_format(date)
    return date.to_formatted_s(:long_ordinal)
  end
  #listing all the alerts
  def list
    @alerts = []
    @alertsRaw = UserAlert.where(user_id: current_user.id)
    @createdAlerts = Alert.where(created_by_id: current_user.id)
    puts @alerts

    @alertsRaw.each do |a|
      @alerts.push(a.alert)
    end

  end

  #for the new alerts
  def new
    @alert = Alert.new
    @types = AlertType.all
    @users = User.where(disabled: false)
    @animals = Animal.all
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
      if params["assignees"]
        arr = params["assignees"].split("|")
        arr.each do |d|
          
        @userAlert = UserAlert.new({alert_id: @alert.id, user_id: d})
        @userAlert.save
        end
      end
      if params["animals"]
        arr = params["animals"].split("|")
        arr.each do |d|
          
        @animalAlert = AnimalAlert.new({alert_id: @alert.id, animal_id: d})
        @animalAlert.save
        end
      end
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
      @AnimalList = AnimalAlert.where(alert_id: @id)
      @UserList = UserAlert.where(alert_id: @id)

      #generate the list of animals
      @AnimalNameList = []
      @AnimalList.each do |a|
          @AnimalNameList.push({
            "id" =>  a.animal.id, 
            "name" => a.animal.name,

          })
      end
      #generate the list of users
      @UserNameList = []
      @UserList.each do |a|
          @UserNameList.push({
            "id" =>  a.user.id, 
            "name" => a.user.name,

          })
      end
      #generate the json to be returned
      @str = {
        "id" => @alert.id, 
        "title" => @alert.title, 
        "description" => @alert.description,
        "date" => date_format(@alert.date),
        "created_by" =>  [{"name" => @alert.created_by.name, "id" => @alert.created_by.id}], 
        "location" =>  @alert.location,
        "animals" => @AnimalNameList,
        "users" => @UserNameList,
        "user_id" => current_user.id,
      } 



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
