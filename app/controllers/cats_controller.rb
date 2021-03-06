class CatsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy, :new, :setLocation, :update_information]
  before_action :set_cat, only: [:edit, :update, :destroy, :setLocation, :update_information]
  before_action :shouldBeOwner, only: [:edit, :update, :destroy, :setLocation]

  skip_before_action :verify_authenticity_token, if: :json_request?

  def index
    page = 1
    page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]

    @cats = Cat.paginate(page: page)

    respond_to do |format|
      format.html do
        render 'index'
      end

      format.json do
        render json: @cats
      end
    end
  end

  def show
    @cat = Cat.includes(:user).find_by(id: params[:id])

    respond_to do |format|
      format.html do
        render 'show'
      end

      format.json do
        render :show
      end
    end
  end

  def new
    @user = current_user
    @cat = @user.cats.new
  end

  def edit

  end

  def create
    @cat = Cat.new cat_params
    unless @cat.valid? then
      render json: {success: false, description: "Validate false."}
    end

    if @cat.save then
      render json: {success: true}
    else
      render json: {success: false, description: "save error."}
    end
  end

  def update
    success = false
    description = "Cat Archive update unsuccess"
    if @cat.update_attributes cat_params
      success = true
      description = "Cat Archive update success!"
    end

    respond_to do |format|
      format.html {
        if success then
          flash[:success] = description
          redirect_to @cat
        else
          render 'edit'
        end
      }
      format.json do
        render :show
      end
    end
  end

  def destroy
    success = false
    description = ""

    if @cat.destroy
      success = true
      description = "Destroy cat successfully!"
    else
      success = false
      description = "Destroy cat unsuccessfully :("
    end

    respond_to do |format|
      format.html do
        if success
          flash[:success] = description
        else
          flash[:error] = description
        end
        redirect_to cats_url
      end
      format.json do
        render json: {success: success, description: description}
      end
    end
  end

  def modelKeys
    render json: {
        archive: [
            {
                key: "name",
                placeholder: "",
                title: "名字"
            },
            {
                key: "age",
                placeholder: "",
                title: "年龄"
            },
            {
                key: "breed",
                placeholder: "",
                title: "品种"
            }
        ]
    }
  end

  def setLocation
    locationData = params.require(:cat).permit(:latitude, :longitude)
    @cat.latitude = locationData["latitude"].to_f
    @cat.longitude = locationData["longitude"].to_f
    success = @cat.save
    render json: {
        success: success,
        locationData: locationData
    }
  end

  def nearby
    requestLocation = params.permit(:latitude, :longitude)
    location = [requestLocation["latitude"], requestLocation["longitude"]]
    @cats = Cat.within(5, :origin => location)
    render :index
  end

  private

    def cat_params
      params.require(:cat).permit(:name, :age, :breed, :user_id, :gender, :latitude, :longitude, :avatar)
    end

    def set_cat
      @cat = Cat.find_by(id: params[:id])
    end

    def isOwnerFor?(cat)
      cat.user == current_user
    end

    def shouldBeOwner
      unless isOwnerFor? @cat
        if request.format == :html
          redirect_to root_url
        else
          render json: {
              success: false,
              description: "You should be owner for the cat."
          }
        end
      end
    end

  protected

    def json_request?
      request.format.json?
    end

end
