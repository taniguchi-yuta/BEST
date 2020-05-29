class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: [:update, :destroy]

  def check_guest
    if resource.email == 'guest@example.com'
      flash[:danger] = 'ゲストユーザーの変更・削除はできません'
      redirect_to edit_user_registration_path(@user)
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end
