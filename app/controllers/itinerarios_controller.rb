class ItinerariosController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def create
    # build a new post from the information contained in the "new post" form
    @itinerario = current_user.itinerarios.build(params[:itinerario])

    if @itinerario.save
      flash[:success] = 'Itinerario created!'
      render current_user

    else
      redirect_to 'pages/home'
    end

  end


  def destroy
    @itinerario.destroy
    redirect_to current_user
  end

  #def show_hotel_form

  #end

  private

  def correct_user
    # does the user have a post with the given id?
    @itinerario = current_user.itinerarios.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to 'pages/home' if @itinerario.nil?
  end

end
