class AlertsController < ApplicationController
  def date_format(date)
    return date.to_formatted_s(:long_ordinal)
  end
  #listing all the alerts
  def list
    @allAlerts = []
    @myAlerts = []
    @alertsRaw = UserAlert.where(user_id: current_user.id)
    @createdAlerts = Alert.where(created_by_id: current_user.id)
    puts @alerts

    @alertsRaw.each do |a|
      a.alert.assigned = true
      @myAlerts.push(a.alert)
      @allAlerts.push(a.alert)
    end
    @createdAlerts.each do |a|
      a.assigned = false
      unless (@allAlerts.include?(a))
       @allAlerts.push(a)
     end
    end
  end

  #for the new alerts
  def new
    update_referer(request.referer, request.original_url)
    @animal = Animal.where(id=params["param"])
    @alert = Alert.new
    @types = AlertType.all
    @users = User.where(disabled: false)
    @animals = Animal.all

  end
  def edit
    update_referer(request.referer, request.original_url)
    @alert = Alert.find(params["param"])
    @types = AlertType.all
    @users = User.where(disabled: false)
    @animals = Animal.all
    @assigneesSelected = []
    @animalsSelected = []
    @assigneesRaw = UserAlert.where(alert_id: params["param"])
    @animalsRaw = AnimalAlert.where(alert_id: params["param"])
    @animalsRaw.each do |a|
      @animalsSelected.push(a.animal)
    end
    @assigneesRaw.each do |a|
      @assigneesSelected.push(a.user)
    end

  end
  def unsubscribeAlert
    session[:prev_url] = request.referer

     id = request["param"]
     UserAlert.where("alert_id =" + id.to_s + " and user_id = " + current_user.id.to_s).delete_all

    redirect_to session[:prev_url]

  end 
  def deleteAlert


    id = request["param"]
    AnimalAlert.where("alert_id =" + id.to_s).delete_all
    UserAlert.where("alert_id =" + id.to_s).delete_all
    Alert.where("id =" + id.to_s).delete_all

    redirect_to session[:prev_url]
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
        user = User.find(d)
        UserMailer.alert_email_assigned(user, @alert).deliver_now
        @userAlert.update_attributes(email_date: Time.now)
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
      redirect_to session[:prev_url]
    else       
      flash.now[:danger] = "Error adding Alert!"
      render 'new'
    end
  end

  def editAlert
    @alert = Alert.find(params["format"])
    if @alert.update_attributes(alert_params)
      #delete old ones
      UserAlert.where("alert_id = " + @alert.id.to_s).delete_all
      AnimalAlert.where("alert_id = " + @alert.id.to_s).delete_all
      #add new ones
      if params["assignees"]
        arr = params["assignees"].split("|")
        arr.each do |d|
          
        @userAlert = UserAlert.new({alert_id: @alert.id, user_id: d})
        @userAlert.save
        user = User.find(d)
        UserMailer.alert_email_edited(user, @alert).deliver_now
        @userAlert.update_attributes(email_date: Time.now)
        end
      end
      if params["animals"]
        arr = params["animals"].split("|")
        arr.each do |d|
          
        @animalAlert = AnimalAlert.new({alert_id: @alert.id, animal_id: d})
        @animalAlert.save
        end
      end


      flash[:success] = "Updated Alert"
      redirect_to session[:prev_url]

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
      @assigned = false;
      @UserNameList = []
      @UserList.each do |a|
          if(a.user_id == current_user.id)
            @assigned = true;
          end
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
        "assigned" => @assigned
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
  def update_referer(previous, current)
      if(current!=previous)
        session[:prev_url] = previous.to_s
      end
  end
end
