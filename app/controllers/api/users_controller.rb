class Api::UsersController < Api::ApiController

  def show
    @users = User.find(params[:id])
    respond_to do |format|
      format.json { render json: @users}
    end
  end
end