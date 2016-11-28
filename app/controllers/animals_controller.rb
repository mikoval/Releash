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

  def newAnimal
    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
    if @animal.save
      flash.now[:success] = "New Animal!"
      redirect_to animals_path
    else
      flash.now[:danger] = "Error adding Animal!"
      render 'new'
    end
  end
  private

  def animal_params
    params.require(:animal).permit(:name, :species, :breed)
  end
end
