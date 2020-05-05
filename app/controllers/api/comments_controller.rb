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

end