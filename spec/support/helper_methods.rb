module HelperMethods

  def sign_in(credentials)
    visit exercises_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Kirjaudu sisään')
  end

  def current_user

    user = instance_double("User", :username => "Testi", :realname => "Pekka", :password => "Salasana1", :password_confirmation => "Salasana1", :email => "pekka@pera.com")

    return user
  end
  
  def current_user_is_admin
    return false
  end

end