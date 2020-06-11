class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: [:update, :destroy]

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to edit_user_registration_path(@user)
      flash[:error] = 'ゲストユーザーの変更・削除はできません'
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end
