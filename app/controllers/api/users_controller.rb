class Api::UsersController < Api::ApiController

  def show
    @users = User.find(params[:id])
    respond_to do |format|
      format.json { render json: @users}
    end
  end
  
  
  def create
    @user = User.new(user_params)
    @user.karma = 0
    respond_to do |format|
      if @user.save
        @apiKey = (@user.id).to_s + "_" + SecureRandom.urlsafe_base64
        @user.apiKey = @apiKey
        @user.save
        format.json { render json: {id: @user.id, email: @user.email, apiKey: @user.apiKey}, status: :created}
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def user_params
    params.permit(:name, :email, :password, :about)
  end

end