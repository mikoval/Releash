class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    @species = Species.all
    @breed = Breed.all
  end

  def profile
    @animal = Animal.find(params["param"])
    @documents = Document.where(:animal_id => params["param"])
  end


  def newAnimal

    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
    @species = Species.all
    @breed = Breed.all
    if @animal.save
      params["documents"].each do |d|
        @document = Document.new({animal_id: @animal.id, document: d})
        @document.save
      end

      
        flash.now[:success] = "New Animal!"
        redirect_to :controller => "animals", :action => "profile", :param => @animal

    else
      flash.now[:danger] = "Error adding Animal!"
      render 'new'
    end
  end
  private

  def animal_params


    params.require(:animal).permit(:name, :species_id, :breed_id, :picture)

  end
end
