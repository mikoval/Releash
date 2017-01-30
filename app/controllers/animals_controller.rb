class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    @breed = Breed.all
  end

  def edit
    @animal = Animal.find(params["param"])
    @breed = Breed.all
  end
  
  def profile
    @animal = Animal.find(params["param"])
    @documents = Document.where(:animal_id => params["param"])
  end


  def newAnimal
    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
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

  def editAnimal
    @animal = Animal.find(params["format"])
    if @animal.update_attributes(animal_params)
      flash[:success] = "Saved animal"
      redirect_to :controller => "animals", :action => "profile", :param => @animal
    else
      flash.now[:danger] = "Error editing animal!"
      @breed = Breed.all
      render 'edit'
    end
  end

  def query
    @animals = Animal.all.limit(10)
    arr = []
    @animals.each do |d|
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "primary" => d.primary_breed.name,
        "secondary" => d.secondary_breed.name,
        "picture" => d.picture,
      })
    end
    render json: arr
  end
  def search
    @search = params["q"]
    @breed = Breed.where('LOWER(name) LIKE LOWER(:search)', search: "%#{@search}%" )
    if(@breed.length > 0)
      @breedid = @breed[0].id
    else 
      @breedid = 0
    end

    @animals = Animal.where('LOWER(name) LIKE LOWER(:search) primary_breed_id = :breed' , search: "%#{@search}%", breed: "#{@breedid}")

    arr = []
    @animals.each do |d|
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "primary" => d.primary_breed.name,
        "picture" => d.picture,
      })
    end
    render json: arr
  end

  private

  def animal_params

    params.require(:animal).permit(:name, :primary_breed_id, :picture, :color_primary, :color_secondary, :eye_color,
      :adoption_fee, :animal_type, :birthday, :cage_number, :microchip_number, :tag_number, :neutered
      )

  end
end
