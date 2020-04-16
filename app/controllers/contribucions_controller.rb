class ContribucionsController < ApplicationController
  before_action :set_contribucion, only: [:show, :edit, :update, :destroy, :like, :unlike, :comment]

  # GET /contribucions
  # GET /contribucions.json
  def index_ask
    @contribucions = Contribucion.all.order("created_at DESC")
  end

  # GET /contribucions
  # GET /contribucions.json
  def index_ordered
      if params[:user_id]
         @contribucions = Contribucion.where(user_id: params[:user_id])
         @replies = Reply.where(user_id: params[:user_id])
      else
         @contribucions = Contribucion.all.order("created_at DESC")
      end
  end
  
  def index_upvoted
    @contribucions = current_user.get_up_voted Contribucion
  end
  
  # GET /contribucions
  # GET /contribucions.json
  def index
    @contribucions = Contribucion.all.order(cached_votes_up: :desc)
  end

  # GET /contribucions/1
  # GET /contribucions/1.json
  def show
  end

  # GET /contribucions/new
  def new
    @contribucion = Contribucion.new
  end

  # GET /contribucions/1/edit
  def edit
  end
  
  def comment
    if !current_user().nil?
      @user_id = current_user().id
      @contribucion = Contribucion.find(params[:id])
      @comment = @contribucion.comments.create(content: params[:content], user_id: @user_id)
      flash[:notice] = "Added your comment"
      redirect_to :action => "show", :id => params[:id]
    else
      redirect_to '/login'
    end
  end

  # POST /contribucions
  # POST /contribucions.json
  def create
    if !current_user().nil?
      @contribucion = Contribucion.new(contribucion_params)
      @contribucion.user = current_user
      if @contribucion.url.empty?
        @contribucion.tipus = 'ask'
      else 
        @contribucion.tipus = 'url'
      end
  
      respond_to do |format|
        if @contribucion.save
          format.html { redirect_to '/newest', notice: 'Contribucion was successfully created.' }
          format.json { render :show, status: :created, location: @contribucion }
        else
          format.html { render :new }
          format.json { render json: @contribucion.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to user_facebook_omniauth_authorize_path
    end
  end

  # PATCH/PUT /contribucions/1
  # PATCH/PUT /contribucions/1.json
  def update
    respond_to do |format|
      if @contribucion.update(contribucion_params)
        format.html { redirect_to @contribucion, notice: 'Contribucion was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribucion }
      else
        format.html { render :edit }
        format.json { render json: @contribucion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribucions/1
  # DELETE /contribucions/1.json
  def destroy
    @contribucion.destroy
    respond_to do |format|
      format.html { redirect_to '/newest', notice: 'Contribucion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def like
    if !current_user().nil?
      @contribucion.liked_by current_user
      @contribucion.user.karma += 1
      @contribucion.user.save
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.json { head :no_content  }
      end
    else
      redirect_to user_facebook_omniauth_authorize_path
    end
  end
   
  def unlike
    @contribucion.unliked_by current_user
    @contribucion.user.karma -= 1
    @contribucion.user.save
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.json { head :no_content  }
    end
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribucion
      @contribucion = Contribucion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribucion_params
      params.require(:contribucion).permit(:title, :url, :text)
    end
end
