class Users::PasswordsController < Devise::PasswordsController
  before_action :check_guest, only: :create

  def check_guest
    if params[:user][:email].downcase == 'guest@example.com'
      redirect_to root_path
      flash[:error] = 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
