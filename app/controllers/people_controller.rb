class PeopleController < ApplicationController
  def list
    @allPeople = User.all
  end

  def new
  	@allPeople = User.new
  end

end
