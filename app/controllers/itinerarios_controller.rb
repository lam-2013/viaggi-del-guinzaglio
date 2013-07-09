class ItinerariosController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def new
    @itinerario = Itinerario.new
  end

  def create
    # build a new post from the information contained in the "new post" form
    @itinerario = current_user.itinerarios.build(params[:itinerario])

    if @itinerario.save
      #flash[:success] = 'Itinerario created!'
      redirect_to new_hotel_path(:itinerario_id => @itinerario.id)
    else
      render 'new'
    end
  end

  def show
    @itinerario = Itinerario.find(params[:id])
    @itinerario_id = @itinerario.id
    @votatos=Votato.all
  end


  def destroy
    @itinerario.destroy
    redirect_to current_user
  end

  def correct_user
    @itinerario=current_user.itinerarios.find_by_id(params[:id])
    redirect_to homepage_users_path if @itinerario.nil?
  end


end
