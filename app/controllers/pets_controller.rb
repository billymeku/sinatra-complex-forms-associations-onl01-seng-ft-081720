class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end
  
    post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      Owner.create(params["owner"]).pets << @pet
    end
    @pet.save
      redirect to "pets/#{@pet.id}"	
  end	  
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    if params[:owner][:name] != @pet.owner.name
      @owner = Owner.create(params[:owner])
      @pet.update(name: params[:pet][:name], owner: @owner)
    else
      @pet.update(params[:pet])
    end

    redirect to "pets/#{@pet.id}"	    
  end	  
  
end