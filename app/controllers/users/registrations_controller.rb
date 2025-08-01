# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   skip_before_action :authenticate_user!, only: [ :create ]
   before_action :configure_sign_up_params, only: [ :create ]
   before_action :configure_account_update_params, only: [ :update, :edit ]

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

  def show
    @user = current_user
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

   # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
   end

   # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :avatar, :goal_steps ])
   end

   # サインイン後のリダイレクト先を指定する
   def after_sign_up_path_for(resource)
     root_path
   end

   # サインアウト後のリダイレクト先を指定する
   def after_inactive_sign_up_path_for(resource)
     root_path
   end

   def update_resource(resource, params)
    resource.update_without_password(params)
   end
end
