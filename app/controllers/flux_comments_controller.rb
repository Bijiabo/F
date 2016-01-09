class FluxCommentsController < ApplicationController
  before_action :set_flux_comment, only: [:show, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /flux_comments
  # GET /flux_comments.json
  def index
    page = 1
    page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]

    @flux_comments = FluxComment.paginate(page: page).includes(:user)

    respond_to do |format|
      format.html do
        render 'index'
      end

      format.json do
        flux_comments_data = []

        @flux_comments.each do |flux_comment|
          data_item = {comment: flux_comment}
          data_item["user"] = {
              id: flux_comment.user.id,
              name: flux_comment.user.name
          }
          flux_comments_data.push data_item
        end

        render json: flux_comments_data
      end

    end
  end

  # GET /flux_comments/1
  # GET /flux_comments/1.json
  def show

    respond_to do |format|
      format.html {render 'show'}
      format.json do
        user = @flux_comment.user
        render json: {
            comment: @flux_comment,
            user: {
                id: user.id,
                name: user.name
            }
        }
      end
    end
  end

  # GET /flux_comments/new
  def new
    @flux_comment = FluxComment.new
  end

  # GET /flux_comments/1/edit
  def edit
  end

  # POST /flux_comments
  # POST /flux_comments.json
  def create
    p flux_comment_params
    @flux_comment = FluxComment.new(flux_comment_params)

    respond_to do |format|
      if @flux_comment.save
        # update flux comment count
        if flux = Flux.find_by(params[:flux_id])
          flux.increment :comment_count, 1
          flux.save
        end

        format.html { redirect_to @flux_comment, notice: 'Flux comment was successfully created.' }
        format.json { render :show, status: :created, location: @flux_comment }
      else
        format.html { render :new }
        format.json { render json: @flux_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flux_comments/1
  # PATCH/PUT /flux_comments/1.json
  def update
    respond_to do |format|
      if @flux_comment.update(flux_comment_params)
        format.html { redirect_to @flux_comment, notice: 'Flux comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @flux_comment }
      else
        format.html { render :edit }
        format.json { render json: @flux_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flux_comments/1
  # DELETE /flux_comments/1.json
  def destroy
    if @flux_comment.destroy
      if flux = Flux.find_by(params[:flux_id])
        flux.increment :comment_count, -1
        flux.save
      end
    end

    # TODO: update reply information

    respond_to do |format|
      format.html { redirect_to flux_comments_url, notice: 'Flux comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flux_comment
      @flux_comment = FluxComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flux_comment_params
      params.require(:flux_comment).permit(:content, :user_id, :parentComment_id, :flux_id)
    end

  protected

    def json_request?
      request.format.json?
    end

end
