class FluxesController < ApplicationController
  before_action :set_flux, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /fluxes
  # GET /fluxes.json
  def index
    page = 1
    page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]

    respond_to do |format|
      format.html do
        @fluxes = Flux.paginate(page: page)
        @flux = current_user.fluxes.build if logged_in?
        render 'index'
      end

      format.json do
        @fluxes = Flux.paginate(page: page).includes([:user, :flux_images])
        render :index
      end
    end
  end

  # GET /fluxes/1
  # GET /fluxes/1.json
  def show
    if @flux.nil? then
      error_description = "no such flux."
      respond_to do |format|
        format.html do
          flash[:error] = error_description
          redirect_to error_url
        end
        format.json do
          render json: {error: true, description: error_description}
        end
      end
    else
      respond_to do |format|
        format.html do
          render 'show'
        end

        format.json do
          render :show
        end
      end
    end
  end

  # GET /fluxes/new
  def new
    @user = current_user
    @flux = @user.fluxes.new
  end

  # GET /fluxes/1/edit
  def edit
    @user = current_user
  end

  # POST /fluxes
  # POST /fluxes.json
  def create
    @flux = current_user.fluxes.build flux_params
    picutre_size = FastImage.size flux_image_params[:picture].path
    @flux_images = @flux.flux_images.build({
                                               picture: flux_image_params[:picture],
                                               width: picutre_size[0],
                                               height: picutre_size[1]
    })

    if @flux.save && @flux_images.save
      flash[:success] = "Create flux successfully!"
      respond_to do |format|
        format.html do
          redirect_to fluxes_url
        end

        format.json do
          render json: {success: true}
        end
      end
    else
      respond_to do |format|
        format.html do
          render 'new'
        end

        format.json do
          render json: {error: true}
        end
      end
    end
  end

  # PATCH/PUT /fluxes/1
  # PATCH/PUT /fluxes/1.json
  def update
    success = false
    description = ""
    if @flux.update(flux_params)
      success = true
      description = "Update flux successfully!"
    else
      success =false
      description = "Update flux unsuccessfully :("
    end

    respond_to do |format|
      format.html do
        if success
          flash[:success] = description
          redirect_to @flux
        else
          flash[:error] = description
          redirect_to fluxes_url
        end
      end

      format.json { render json: {success: success, error: !success, description: description} }
    end
  end

  # DELETE /fluxes/1
  # DELETE /fluxes/1.json
  def destroy
    success = false
    description = ""

    if @flux.destroy
      success = true
      description = "Destroy flux successfully!"
    else
      success = false
      description = "Destroy flux unsuccessfully :("
    end

    respond_to do |format|
      format.html do
        if success
          flash[:success] = description
        else
          flash[:error] = description
        end
        redirect_to fluxes_url
      end
      format.json do
        render json: {success: success, description: description}
      end
    end
  end

  def comments
    @comments = FluxComment.includes(:user).where({flux_id: params[:id]})
    render :comments
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flux
      @flux = Flux.includes([:user, :flux_images]).find_by({id: params[:id]})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flux_params
      params.require(:flux).permit(:motion, :content, :user_id)
    end

    def flux_image_params
      params.require(:flux).permit(:picture)
    end

    def correct_user
      @flux = Flux.find(params[:id])
      if @flux.user_id != current_user.id
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

  protected

  def json_request?
    request.format.json?
  end

end
