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
  end


  def newAnimal
    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
    @species = Species.all
    @breed = Breed.all
    if @animal.save
      debugger
      flash.now[:success] = "New Animal!"
      redirect_to :controller => "animals", :action => "profile"
    else
      flash.now[:danger] = "Error adding Animal!"
      render 'new'
    end
  end
  private

  def animal_params


    params.require(:animal).permit(:name, :species_id, :breed, :picture, :documents)

  end
end
