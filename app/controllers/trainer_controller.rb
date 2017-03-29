class TrainerController < ApplicationController
  def new
  	@trainer = Trainer.new()
  end

  def list
  	@allTrainer = Trainer.all
  end

  def edit
  	@trainer = Trainer.find(params["param"])
  end

  def newTrainer
  	@trainer = Trainer.new(trainer_params)

    if @trainer.save
      flash[:success] = "Added Trainer"
      redirect_to :controller => "people", :action => "list", :param => @trainer
    else
      render 'new'
    end
  end
  
  def editTrainer
  	@trainer = Trainer.find(params["format"])
    
    if @trainer.update_attributes(trainer_params)
      flash[:success] = "Added Trainer"
      redirect_to :controller => "people", :action => "list", :param => @trainer
    else
      render 'edit'
    end
  	
  end

  def trainer_params
  	params.require(:trainer).permit(:name, :address , :city , :state, :zip_code, :email)
  end
end
