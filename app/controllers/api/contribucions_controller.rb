class Api::ContribucionsController < Api::ApiController

  def show
    @contribucions = Contribucion.find(params[:id])
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def index
    @contribucions = Contribucion.all
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def index_ask
    @contribucions = Contribucion.where(tipus:'ask')
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def index_ordered
    @contribucions = Contribucion.where(tipus:'url')
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def fromuser
    @contribucions = Contribucion.where(user_id:params[:id])
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def upvotedbyuser
    @user = User.find(params[:id])
    @contribucions = @user.get_up_voted Contribucion
    respond_to do |format|
      format.json { render json: @contribucions}
    end
  end
  
  def create
    
  end
end
