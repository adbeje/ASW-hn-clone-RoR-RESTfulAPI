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


end