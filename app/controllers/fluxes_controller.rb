class FluxesController < ApplicationController
  before_action :set_flux, only: [:show, :edit, :update, :destroy]

  # GET /fluxes
  # GET /fluxes.json
  def index
    @fluxes = Flux.paginate(page: params[:page])
  end

  # GET /fluxes/1
  # GET /fluxes/1.json
  def show
    @flux = Flux.find(params[:id])
  end

  # GET /fluxes/new
  def new
    @flux = Flux.new
  end

  # GET /fluxes/1/edit
  def edit
  end

  # POST /fluxes
  # POST /fluxes.json
  def create
    @flux = Flux.new(flux_params)

    respond_to do |format|
      if @flux.save
        format.html { redirect_to @flux, notice: 'Flux was successfully created.' }
        format.json { render :show, status: :created, location: @flux }
      else
        format.html { render :new }
        format.json { render json: @flux.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fluxes/1
  # PATCH/PUT /fluxes/1.json
  def update
    respond_to do |format|
      if @flux.update(flux_params)
        format.html { redirect_to @flux, notice: 'Flux was successfully updated.' }
        format.json { render :show, status: :ok, location: @flux }
      else
        format.html { render :edit }
        format.json { render json: @flux.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fluxes/1
  # DELETE /fluxes/1.json
  def destroy
    @flux.destroy
    respond_to do |format|
      format.html { redirect_to fluxes_url, notice: 'Flux was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flux
      @flux = Flux.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flux_params
      params.require(:flux).permit(:motion, :content, :user_id)
    end
end
