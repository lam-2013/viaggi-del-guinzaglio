class RistorantesController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def new
    @itinerario = Itinerario.find(params[:itinerario_id])
    @ristorante = Ristorante.new
  end

  # crea un nuovo ristorante collegato all'itinerario id
  def create
    @itinerario=Itinerario.find(params[:ristorante][:itinerario_id])
    @ristorante = @itinerario.ristorantes.build(params[:ristorante])

    if @ristorante.save
      redirect_to new_luogo_path(:itinerario_id => @itinerario.id)
    else
      render 'new'
    end

  end


  # trova ristorante con l'id dell'itinerario selezionato per la modifica
  def edit
    @ristorante = Ristorante.find_by_itinerario_id(params[:id])
  end


  # aggiorna dati ristorante dopo la modifica
  def update

    @itinerario=Itinerario.find(params[:ristorante][:itinerario_id])
    @ristorante=Ristorante.find_by_itinerario_id(@itinerario.id)

    if @ristorante.update_attributes(params[:ristorante])
      redirect_to  @itinerario
    else
      render 'edit'
    end
  end

  def show
    @ristorante = Ristorante.find(params[:id])
  end



  def destroy
    @ristorante.destroy
    redirect_to current_user
  end

  private

  def correct_user
    # does the user have a post with the given id?
    @ristorante = current_user.ristorantes.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to 'pages/home' if @ristorante.nil?
  end

end
