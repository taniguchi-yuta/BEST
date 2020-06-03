class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |guest_user|
      user.name = "ゲストユーザー"
      user.introduction = "ゲストユーザーです。"
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to user_path(user)
  end
end
