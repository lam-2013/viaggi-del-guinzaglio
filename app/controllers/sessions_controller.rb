class SessionsController < ApplicationController

  def new
    # intentionally left empty: no need to pass any data to the sign in form
  end

  def create
    # gestisce oauth login
    auth = request.env['omniauth.auth']
    if auth
      if auth[:provider] == 'twitter'
        email = "#{auth[:info][:nickname]}@twitter.com"
      elsif auth[:provider] == 'facebook'
        email = auth[:info][:email]
      end
      if email
        # controlla se l'utente è registrato
        user = User.find_by_email(email.downcase)
        # se no, crea nuovo utente
        user = User.create_with_omniauth(auth) unless user
        sign_in user
        # indirizza alla homepage
        redirect_to homepage_users_path
      end
    # login normale
    else
      # controlla email
      user = User.find_by_email(params[:session][:email].downcase)
      # controlla password
      if user && user.authenticate(params[:session][:password])
        # login effettuato
        sign_in user #  SessionsHelper class
        redirect_to homepage_users_path
      else
        # errori nella compilazione del form
        flash.now[:error] = 'Invalid email/password combination'
        # si torna alla pagina di login
        redirect_to signin_path
      end
    end
  end


  def destroy
    # sign out the current user
    sign_out
    # go to the home
    redirect_to root_path
  end

end
