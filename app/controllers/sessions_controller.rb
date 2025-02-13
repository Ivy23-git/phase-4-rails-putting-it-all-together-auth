class SessionsController < ApplicationController
    def create 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id 
          render json: user
        else 
          render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
      end
  
      def destroy 
        if session[:user_id].present?
          session.delete(:user_id)
          head :no_content
        else 
          render json: { error: ["Not logged in"] }, status: :unauthorized
        end
      end
end
