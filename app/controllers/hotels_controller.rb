class HotelsController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: :destroy

  def create
    # build a new post from the information contained in the "new post" form

    @hotel = current_it.hotels.build(params[:hotel])

    if @hotel.save
      flash[:success] = 'Hotel created!'
      redirect_to ""
    else
      redirect_to 'pages/home'
    end

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
