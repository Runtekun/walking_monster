# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [ :create ]

   protected

   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [ :attribute ])
   end

   def after_sign_in_path_for(resource)
     root_path
   end

   # サインアウト後のリダイレクト先を指定するメソッドを追加する。
   def after_sign_out_path_for(resource_or_scope)
     root_path
   end
end
