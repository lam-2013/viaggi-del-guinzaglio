class LuogosController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def new
    @itinerario = Itinerario.find(params[:itinerario_id])
    @luogo = Luogo.new
  end

  # crea un nuovo luogo collegato all'itinerario id
  def create
    @itinerario=Itinerario.find(params[:luogo][:itinerario_id])
    @luogo = @itinerario.luogos.build(params[:luogo])

    if @luogo.save
      redirect_to @itinerario
    else
      render 'new'
    end

  end

  # trova luogo con l'id dell'itinerario selezionato per la modifica
  def edit
    @luogo = Luogo.find_by_itinerario_id(params[:id])
  end


  # aggiorna dati hotel dopo la modifica
  def update
     @itinerario=Itinerario.find(params[:luogo][:itinerario_id])
     @luogo=Luogo.find_by_itinerario_id(@itinerario.id)

    if @luogo.update_attributes(params[:luogo])
      redirect_to  @itinerario
    else
      render 'edit'
    end
  end


  def show
    @luogo = Luogo.find(params[:id])
  end


  def destroy
    @luogo.destroy
    redirect_to current_user
  end

  private

  def correct_user
    # does the user have a post with the given id?
    @luogo = current_user.luogos.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to 'pages/home' if @luogo.nil?
  end

end
