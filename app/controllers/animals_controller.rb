class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    @breed = Breed.order('name ASC')
  end

  def edit
    @animal = Animal.find(params["param"])
    @breed = Breed.order('name ASC')
    @breeds = AnimalBreed.where("animal_id = " + params["param"])

  end
  
  def profile
    @animal = Animal.find(params["param"])
    @breeds = AnimalBreed.where("animal_id = " + params["param"])

  end


  def newAnimal
    @animal = Animal.new(animal_params)
    @allAnimals = Animal.all
    @breed = Breed.all
    if @animal.save
      #this code was for old documents
      if params["breeds"]
        arr = params["breeds"].split("|")
        arr.each do |d|
          
        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
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
      if params["breeds"]
        arr = params["breeds"].split("|")
        AnimalBreed.where("animal_id = " +  @animal.id.to_s).destroy_all

        arr.each do |d|
        str = "animal_id = " +  @animal.id.to_s + " and breed_id = " + d

        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
        end
      end
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
      sBreed = '';
      if(d.secondary_breed_id)
        sBreed = d.secondary_breed.name
      end
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "primary" => d.primary_breed.name,
        "secondary" => sBreed,
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
    
    @users = User.where('LOWER(name) LIKE LOWER(:search)', search: "%#{@search}%" )
    if(@users.length > 0)
      @usersid = @users[0].id
    else 
      @usersid = 0
    end

    @animals = Animal.where('LOWER(name) LIKE LOWER(:search) OR primary_breed_id = :breed' , search: "%#{@search}%", breed: "#{@breedid}")
    @user = User.where('LOWER(name) LIKE LOWER(:search)' , search: "%#{@search}%")
    
    arr = []

    @animals.each do |d|
      sBreed = '';
      if(d.secondary_breed_id)
        sBreed = d.secondary_breed.name
      end
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "primary" => d.primary_breed.name,
        "secondary" => sBreed,
        "picture" => d.picture,
      })
    end

    
    render json: arr
  end
  private

  def animal_params

    params.require(:animal).permit(:name, :primary_breed_id, :picture, :status, :color_primary, :color_secondary, :eye_color,
      :adoption_fee, :animal_type, :birthday, :cage_number, :microchip_number, :tag_number, :neutered,  

      :intake_document, :owner_surrender_document, :home_check_document, :match_application_document, :adoption_application_document, 
      :adoption_contract_document, :vetting_document
      )

  end
end

