class Api::RepliesController < Api::ApiController
    
def show
    @replies = Reply.find(params[:id])
    respond_to do |format|
      format.json { render json: @replies}
    end
end
  
def showall
    @replies = Reply.all
    respond_to do |format|
      format.json { render json: @replies}
    end
end
  
def fromuser
    @replies = Reply.where(user_id:params[:id])
    respond_to do |format|
      format.json { render json: @replies}
    end
end

def fromcomment
    @replies = Reply.where(comment_id:params[:id])
    respond_to do |format|
      format.json { render json: @replies}
    end
end

def upvotedbyuser
    @user = User.find(params[:id])
    @replies = @user.get_up_voted Reply
    respond_to do |format|
      format.json { render json: @replies}
    end
end

def postreply
    @user = User.find_by_apiKey(params[:apiKey])
    params.delete :apiKey

    if !@user.nil?
      @comment = Comment.find(params[:id])
      if @comment.nil?
        format.json { render status: :bad_request }
      end
      @reply = Reply.new(content: params[:content], user_id: @user.id, comment_id: params[:id])

      respond_to do |format|

        if @reply.save()
          format.json { render status: :created, json: @reply }
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
  @userAK = User.find_by_apiKey(params[:apiKey])
  @reply = Reply.find(params[:id])
  if @userAK.id == @reply.user_id
    respond_to do |format|
      if @reply.update(replies_params)
        format.json { render status: :ok, json: @reply }
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

  def delete
    @userAK = User.find_by_apiKey(params[:apiKey])
    @reply = Reply.find(params[:id])
    if @userAK.id == @reply.user_id
      respond_to do |format|
        if @reply.delete
          format.json { render status: :ok, json: @reply }
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

def replies_params
  params.permit(:content)
end

end