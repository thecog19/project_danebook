module LoginMacros
  def sign_in(user)
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log In'
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end
end
