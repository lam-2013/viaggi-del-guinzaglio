class SessionsController < ApplicationController

  def new
    # intentionally left empty: no need to pass any data to the sign in form
  end

  def create
# oauth login
    auth = request.env['omniauth.auth']
    if auth
      if auth[:provider] == 'twitter'
        email = "#{auth[:info][:nickname]}@twitter.com"
      elsif auth[:provider] == 'facebook'
        email = auth[:info][:email]
      end
      if email
# is user already signed up?
        user = User.find_by_email(email.downcase)
# otherwise, create a new user
        user = User.create_with_omniauth(auth) unless user
        sign_in user
        redirect_to homepage_users_path
      end
# normal login procedure
    else
# get the user email from the sign in form
      user = User.find_by_email(params[:session][:email].downcase)
# check if the retrieved user is valid
      if user && user.authenticate(params[:session][:password])
# handle successful login
        sign_in user # sign in method implemented in the SessionsHelper class
        redirect_to homepage_users_path # redirect to user profile page (same of redirect_to user_path(user))
      else
# handle wrong login information, by using flash.now that is specifically design for showing the flash on rendered page
        flash.now[:error] = 'Invalid email/password combination'
# go back to the sign in page
# render 'new'
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
