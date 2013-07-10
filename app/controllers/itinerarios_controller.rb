class ItinerariosController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def new
    @itinerario = Itinerario.new
  end

  # creato un nuovo itinerario, lo salva nel db e indirizza al form dell'hotel
  def create
    @itinerario = current_user.itinerarios.build(params[:itinerario])

    if @itinerario.save
      redirect_to new_hotel_path(:itinerario_id => @itinerario.id)
    else
      render 'new'
    end
  end

  def show
    @itinerario = Itinerario.find(params[:id])
    @itinerario_id = @itinerario.id
    # prende dal db contenuto di Votatos: id_user votante - id_itinerario votato
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
