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

      #itinerari fatti dall'utente ( current o selezionato )
      @itinerarios = @user.itinerarios.paginate(page: params[:page], :per_page => 3)

  end

  def new
    auth_hash = request.env['omniauth.auth']
    if params[:provider].nil?
      # init the user variable to be used in the sign up form
      @user = User.new
    else
      # oauth
      if auth_hash.nil? #redirect to the service provider auth page
        redirect_to '/auth/'+params[:provider];
      # twitter
      elsif params[:provider]=='twitter'
        @user = User.new(
            twitter_uid: auth_hash[:uid],
            name: auth_hash[:info][:name])
      # facebook
      elsif params[:provider]=='facebook'
        @user = User.new(
            facebook_uid: auth_hash[:credentials][:token],
            name: auth_hash[:info][:name],
            email: auth_hash[:info][:email])
      end
    end
  end


  def create
    @user=User.new(params[:user])
    if @user.save
      # dopo aver creato l'utente mostra la sua pagina profilo
      sign_in @user
      redirect_to homepage_users_path
    else
      render 'new'
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to current_user
  end

  def edit

  end

  def update

    # aggiorna dati dell'utente
    if @user.update_attributes(params[:user])

      sign_in @user
      redirect_to @user
    else
      # aggiornamento fallito
      render 'edit'
    end
  end


  # Actions to list the followed users and the followers of a user
  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 10)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 10)
    render 'show_follow'
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