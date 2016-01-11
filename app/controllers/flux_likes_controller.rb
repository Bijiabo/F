class FluxLikesController < ApplicationController
  before_action :set_flux_like, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /flux_likes
  # GET /flux_likes.json
  def index
    @flux_likes = FluxLike.all
  end

  # GET /flux_likes/1
  # GET /flux_likes/1.json
  def show
  end

  # GET /flux_likes/new
  def new
    @flux_like = FluxLike.new
  end

  # GET /flux_likes/1/edit
  def edit
  end

  # POST /flux_likes
  # POST /flux_likes.json
  def create
    @flux_like = FluxLike.new(flux_like_params)

    if @flux_like.user.id != current_user.id
      render json: {success: false, description: 'Parameter error: wrong user id.'}
      return
    end

    respond_to do |format|
      if @flux_like.save

        if flux = Flux.find_by(id: @flux_like.flux.id)
          # update flux comment count
          flux.increment :like_count, 1
          flux.save

          # send trends to user
          createTrends flux.user_id, TrendsHelper::Type::FLUX_LIKE, flux
        end

        format.html { redirect_to @flux_like, notice: 'Flux like was successfully created.' }
        format.json { render :show, status: :created, location: @flux_like }
      else
        format.html { render :new }
        format.json { render json: @flux_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flux_likes/1
  # PATCH/PUT /flux_likes/1.json
  def update
    respond_to do |format|
      if @flux_like.update(flux_like_params)
        format.html { redirect_to @flux_like, notice: 'Flux like was successfully updated.' }
        format.json { render :show, status: :ok, location: @flux_like }
      else
        format.html { render :edit }
        format.json { render json: @flux_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flux_likes/1
  # DELETE /flux_likes/1.json
  def destroy
    reduce_flux_like_count

    @flux_like.destroy
    respond_to do |format|
      format.html { redirect_to flux_likes_url, notice: 'Flux like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel_like
    @flux_like = FluxLike.find_by flux_id: params[:flux_id]
    reduce_flux_like_count
    result = {success: false}
    unless @flux_like
      result = {success: false, description: 'Like not exists.'}
    else
      @flux_like.destroy
      result = {success: true, description: 'Like has been canceled.'}
    end

    render json: result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flux_like
      @flux_like = FluxLike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flux_like_params
      params.require(:flux_like).permit(:user_id, :flux_id)
    end

    def logged_in_user
      unless logged_in?
        store_location

        error_massage = "Please log in."
        flash[:danger] = error_massage

        if request.format == :html
          redirect_to login_url
        else
          render json: {error: true, description: error_massage}
        end
      end
    end

    def correct_user
      @flux_like = FluxLike.find(params[:id])
      if @flux_like.user_id != current_user.id
        respond_to do |format|
          format.html do
            redirect_to fluxes_url
          end

          format.json do
            render json: {error: true, description: "not the correct user."}
          end
        end
      end
    end

    def reduce_flux_like_count
      if flux = Flux.find_by(@flux_like.flux.id)
        flux.increment :like_count, -1
        flux.save
      end
    end

  protected

    def json_request?
      request.format.json?
    end
end
