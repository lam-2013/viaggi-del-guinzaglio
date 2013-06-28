class UsersController < ApplicationController
  # check if the user is logged in (e.g., for editing only his information)
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  # check if the current user is the correct user (e.g., for editing only his information)
  before_filter :correct_user, only: [:edit, :update]
  # check if the current user is also an admin
  before_filter :admin_user, only: :destroy


  def show

      @user=User.find(params[:id])
      @itinerario = current_user.itinerarios.build if signed_in?

      #per vedere i post
      @itinerarios = @user.itinerarios.paginate(page: params[:page])

  end

  def new
    @user = User.new

  end

  def create
    @user=User.new(params[:user])
    if @user.save
      #redirect_to '/home'
      flash[:success] = "Benvenuto!"
      redirect_to @user
    else
      render 'new'
    end

  end

  def edit
    #@user=User.find(params[:id])

  end

  def update
    #@user=User.find(params[:id])

    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # re-login the user
      sign_in @user
      # go to the user profile
      redirect_to @user
    else
      # handle a failed update
      render 'edit'
    end
  end

  def vote

  end

  # Actions to list the followed users and the followers of a user
  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def homepage


  end

  def homepage2

     @itinerarios = Itinerario.find_all_by_user_id(current_user.followed_users)

  end


  # Take the current user information (id) and redirect her to the home page if she is not the 'right' user
  def correct_user
    # init the user object to be used in the edit and update actions
    @user = User.find(params[:id])
    redirect_to 'home' unless current_user?(@user) # the current_user?(user) method is defined in the SessionsHelper
  end

  # Redirect the user to the home page is she is not an admin (e.g., if the user cannot perform an admin-only operation)
  def admin_user
    redirect_to 'home' unless current_user.admin?
  end

  def search

  end

end