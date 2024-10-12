class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :initialize_gon, :set_gon, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :password, :password_confirmation, :last_name, :first_name,
                                             :last_name_kana, :first_name_kana, :birth_date])
  end

  def initialize_gon
    gon.push({})
  end

  def set_gon
    gon.push({})
  end
end
