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
      if params["documents"]
        params["documents"].each do |d|
          @document = Document.new({animal_id: @animal.id, document: d})
          @document.save
        end
      end

      
        flash.now[:success] = "New Animal!"
        redirect_to :controller => "animals", :action => "profile", :param => @animal

    else
      flash.now[:danger] = "Error adding Animal!"
      render 'new'
    end
  end
  def query
    @animals = Animal.all.limit(10)
    arr = []
    @animals.each do |d|
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "species" => d.species.kind,
        "breed" => d.breed.name,
        "picture" => d.picture,
      })
    end
    render json: arr
  end
  def search
    @search = params["q"]
    @breed = Breed.where('name LIKE :search', search: "%#{@search}%" )
    if(@breed.length > 0)
      @breedid = @breed[0].id
    else 
      @breedid = 0
    end
    @species = Species.where('kind LIKE :search', search: "%#{@search}%" )
    if(@species.length > 0)
      @speciesid = @species[0].id
    else 
      @speciesid = 0
    end
    @animals = Animal.where('name LIKE :search OR species_id = :species OR breed_id = :breed' , search: "%#{@search}%", breed: "#{@breedid}", species: "#{@speciesid}" )

    arr = []
    @animals.each do |d|
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "species" => d.species.kind,
        "breed" => d.breed.name,
        "picture" => d.picture,
      })
    end
    render json: arr
  end

  private

  def animal_params

    params.require(:animal).permit(:name, :species_id, :breed_id, :picture)

  end
end
