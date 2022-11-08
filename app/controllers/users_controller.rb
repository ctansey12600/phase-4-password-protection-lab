class UsersController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  skip_before_action :authorized, only: [:show]

  def create
    user = User.create!(user_params)
    render json: user, status: :created
  end

  def show
    current_user = User.find(session[:user_id])
    render json: current_user
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

  def render_unprocessable_entity(invalid)
    render json: {error: invalid.record.errors}, status: :unprocessable_entity
  end
  
end
