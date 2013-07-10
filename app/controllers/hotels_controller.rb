class HotelsController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy


  def new
    @itinerario = Itinerario.find(params[:itinerario_id])
    @hotel = Hotel.new
  end


  # crea un nuovo hotel collegato all'itinerario id
  def create
    @itinerario=Itinerario.find(params[:hotel][:itinerario_id])
    @hotel = @itinerario.hotels.build(params[:hotel])

    if @hotel.save
      # manda al form di compilazione di un nuovo ristorante
      redirect_to new_ristorante_path(:itinerario_id => @itinerario.id)
    else
      render 'new'
    end

  end

  # trova hotel con l'id dell'itinerario selezionato per la modifica
  def edit
       @hotel = Hotel.find_by_itinerario_id(params[:id])
  end

  # aggiorna dati hotel dopo la modifica
  def update
    @itinerario=Itinerario.find(params[:hotel][:itinerario_id])
    @hotel=Hotel.find_by_itinerario_id(@itinerario.id)

    if @hotel.update_attributes(params[:hotel])
      redirect_to @itinerario
    else
      render 'edit'
    end
  end

  # completa itinerario quando l'utente interrompe creazione itinerario e poi la riprende
  def add
    @itinerario = Itinerario.find(params[:itinerario])
    @hotel = Hotel.new
  end


  def show
    @hotel = Hotel.find(params[:id])
  end


  def destroy
    @hotel.destroy
    redirect_to current_user
  end

  private

  def correct_user
    # does the user have a post with the given id?
    @hotel = current_user.hotels.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to 'pages/home' if @hotel.nil?
  end

end
