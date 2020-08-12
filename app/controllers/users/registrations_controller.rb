# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      @user = User.new(sign_up_params)
    else
      @user = User.new(sign_up_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end
    end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @delivery_information = @user.build_delivery_information
      render :new_delivery_information  
  end

  def create_delivery_information
    @user = User.new(session["devise.regist_data"]["user"])
    @delivery_information = DeliveryInformation.new(delivery_information_params)
    unless @delivery_information.valid?
      flash.now[:alert] = @delivery_information.errors.full_messages
      render :new_delivery_information and return
    end
    @user.build_delivery_information(@delivery_information.attributes)
    if @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
    else
      render :new
    end
  end
  
  protected

  def delivery_information_params
    params.require(:delivery_information).permit(:prefecture_id, :delivery_family_name, :delivery_first_name, :delivery_family_name_furigana, :delivery_first_name_furigana, :postal_code, :city, :address, :building_room_number, :phone_number)
  end
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
