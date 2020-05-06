class Api::CommentsController < Api::ApiController
    
  def show
      @comments = Comment.find(params[:id])
      respond_to do |format|
        format.json { render json: @comments}
      end
  end
    
  def showall
      @comments = Comment.all
      respond_to do |format|
        format.json { render json: @comments}
      end
  end
    
  def fromuser
      @comments = Comment.where(user_id:params[:id])
      respond_to do |format|
        format.json { render json: @comments}
      end
  end
  
  def fromcontribucion
      @comments = Comment.where(contribucion_id:params[:id])
      respond_to do |format|
        format.json { render json: @comments}
      end
  end
  
  def upvotedbyuser
      @user = User.find(params[:id])
      @comments = @user.get_up_voted Comment
      respond_to do |format|
        format.json { render json: @comments}
      end
  end
  
  def postcomment
      @user = User.find_by_apiKey(params[:apiKey])
      params.delete :apiKey
  
      if !@user.nil?
        @contribucion = Contribucion.find(params[:id])
        if @contribucion.nil?
          format.json { render status: :bad_request }
        end
        @comment = Comment.new(content: params[:content], user_id: @user.id, contribucion_id: params[:id])
  
        respond_to do |format|
          if @comment.save()
            format.json { render status: :created, json: @comment }
          else
            format.json { render status: :bad_request }
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
    @comment = Comment.find(params[:id])
    if !@userexternal.nil?
        if @userexternal.id == @comment.user_id
          respond_to do |format|
            if @comment.update(comments_params)
              format.json { render status: :ok, json: @comment }
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
    @comment = Comment.find(params[:id])
    if @userexternal.id == @comment.user_id
      respond_to do |format|
        if @comment.delete
          format.json { render status: :ok, json: @comment }
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
  
    def vote
      if !params[:apiKey].nil?
        @user = User.find_by_apiKey(params[:apiKey])
        @comment = Comment.find(params[:id])
        @comment.liked_by @user
        @comment.user.karma += 1
        @comment.user.save
        respond_to do |format|
          format.json { render json: @comment, status: 200 }
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
      @comment = Comment.find(params[:id])
      @comment.unliked_by @user
      @comment.user.karma -= 1
      @comment.user.save
      respond_to do |format|
        format.json { render json: @comment, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render status: :method_not_allowed }
      end
    end
  end

  

def comments_params
  params.permit(:content)
end
end