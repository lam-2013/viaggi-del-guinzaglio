class HotelsController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def new
    @itinerario = Itinerario.find(params[:itinerario_id])
    @hotel = Hotel.new
  end

  def create
    # build a new post from the information contained in the "new post" form
    @itinerario=Itinerario.find(params[:hotel][:itinerario_id])
    @hotel = @itinerario.hotels.build(params[:hotel])

    if @hotel.save
      #flash[:success] = 'Hotel created!'
      redirect_to new_ristorante_path(:itinerario_id => @itinerario.id)
    else
      render 'new'
    end

  end

  def edit
       #@itinerario_id = Itinerario.find(params[:itinerario_id]).id
       @hotel = Hotel.find_by_itinerario_id(params[:id])
  end

  def update

    #@itinerario_id=Hotel.find(params[:id]).itinerario_id
    @itinerario=Itinerario.find(params[:hotel][:itinerario_id])
    @hotel=Hotel.find_by_itinerario_id(@itinerario.id)

    if @hotel.update_attributes(params[:hotel])
      # handle a successful update
      #flash[:success] = 'Hotel updated'
      # go to the user profile
      redirect_to @itinerario
    else
      # handle a failed update
      render 'edit'
    end
  end

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
