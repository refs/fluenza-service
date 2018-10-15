class V1::UsersController < V1::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user, only: [:create]

  def create
    user = User.new(user_params)
    render json: user.errors.messages, head: :unprocessable_entity unless user.save
  end

  def show
    return head :forbidden if @current_user.id != params[:id].to_i
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
