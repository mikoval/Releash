class MainController < ApplicationController
  def home
  end

  def animals
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def newAnimal
    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
    if @animal.save
      flash.now[:success] = "New Animal!"
      redirect_to animals_path
    else
      flash.now[:danger] = "Error adding Animal!"
      render 'animals'
    end
  end

  def people
  end


  private

    def animal_params
      params.require(:animal).permit(:name, :species)
    end
end
