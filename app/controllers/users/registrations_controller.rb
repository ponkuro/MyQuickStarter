class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def build_resource(hash = nil)
    hash[:uid] = User.create_unique_string
    super
  end

  # 更新時のパスワード判定を回避する
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :provider, :uid, :password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
end
