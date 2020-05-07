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
  
  def vote
    if !params[:apiKey].nil?
      @user = User.find_by_apiKey(params[:apiKey])
      if @user.nil?
        respond_to do |format|
          format.json { render json: {errors: 'Invalid apiKey'}, status: :method_not_allowed }
        end
      else
      @contribucion = Contribucion.find(params[:id])
      if @user.voted_up_on? @contribucion
        respond_to do |format|
          format.json { render json: {errors: 'You cant vote twice'}, status: :method_not_allowed }
        end
      else  
          if @user.id != @contribucion.user_id
                @contribucion.liked_by @user
                @contribucion.user.karma += 1
                @contribucion.user.save
                respond_to do |format|
                  format.json { render json: @contribucion, status: 200 }
                end
          else
            respond_to do |format|
              format.json { render json: {errors: 'You can not vote yourself'}, status: :method_not_allowed }
            end
          end
      end
      end
    else
      respond_to do |format|
        format.json { render status: :method_not_allowed }
      end
    end
  end
  
  def downvote
    if !params[:apiKey].nil?
      @user = User.find_by_apiKey(params[:apiKey])
      if @user.nil?
        respond_to do |format|
          format.json { render json: {errors: 'Invalid apiKey'}, status: :method_not_allowed }
        end
      else
      @contribucion = Contribucion.find(params[:id])
      if @user.voted_down_on? @contribucion
        respond_to do |format|
          format.json { render json: {errors: 'You cant downvote twice'}, status: :method_not_allowed }
        end
      else  
          if @user.id != @contribucion.user_id
                @contribucion.unliked_by @user
                @contribucion.user.karma -= 1
                @contribucion.user.save
                respond_to do |format|
                  format.json { render json: @contribucion, status: 200 }
                end
          else
            respond_to do |format|
              format.json { render json: {errors: 'You can not downvote yourself'}, status: :method_not_allowed }
            end
          end
      end
      end
    else
      respond_to do |format|
        format.json { render status: :method_not_allowed }
      end
    end
  end
  
  def create
    if !params[:apiKey].nil?
    @user = User.find_by_apiKey(params[:apiKey])
    params.delete :apiKey

    if !@user.nil?
      @contribucion = Contribucion.new(contribucion_params)
        if @contribucion.url.nil?
          @contribucion.tipus = "ask"
        else
          if !@contribucion.url.nil?
            if @contribucion.url != ""
              @contribucion.tipus = "url"
            else
              @contribucion.tipus = "ask"
            end
          end
        end
        respond_to do |format|
          @contribucion.user_id = @user.id
          if @contribucion.save
            format.json { render :show, status: :created, json: @contribucion }
          else
            format.json { render json: @contribucion.errors, status: :unprocessable_entity }
          end
        end
    else
      respond_to do |format|
        format.json { render json: {errors: 'Method not Allowed'}, status: :method_not_allowed }
      end
    end
    else
      respond_to do |format|
        format.json { render json: {errors: 'Method not Allowed'}, status: :method_not_allowed }
      end
    end
  end
  
  def edit
    @userexternal = User.find_by_apiKey(params[:apiKey])
    @contribucion = Contribucion.find(params[:id])
    if !@userexternal.nil?
        if @userexternal.id == @contribucion.user_id
          respond_to do |format|
            if @contribucion.update(contribucion_params)
              format.json { render status: :ok, json: @contribucion }
            else
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
    
        else
          respond_to do |format|
            format.json { render json: {errors: 'Method not Allowed'}, status: :method_not_allowed }
          end
        end
    else
       respond_to do |format|
            format.json { render json: {errors: 'ApiKey does not exist'}, status: :method_not_allowed }
      end
    end
  end
  
  def delete
    @userexternal = User.find_by_apiKey(params[:apiKey])
    @contribucion = Contribucion.find(params[:id])
    if @userexternal.nil?
      respond_to do |format|
        format.json { render json: {errors: 'ApiKey does not exist'}, status: :method_not_allowed }
      end
    else
        if @userexternal.id == @contribucion.user_id
          respond_to do |format|
            if @contribucion.delete
              format.json { render status: :ok, json: @contribucion }
            else
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
    
        else
          respond_to do |format|
            format.json { render json: {errors: 'Method not Allowed'}, status: :method_not_allowed }
          end
        end
    end
  end
  
  def contribucion_params
    params.permit(:title, :url, :text, :tipus)
  end
end
