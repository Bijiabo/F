class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :tokens, :create_token, :following, :followers, :avatar, :self_information, :update_information]
  before_action :set_user, only: [ :edit, :update, :destroy, :cats, :avatar]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.includes([:cats]).find_by(id: params[:id])
    if @user.nil?
      error_description = "no such user."
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
      @fluxes = Flux.includes([:user, :flux_images]).order(created_at: :desc).where(user_id: @user.id).paginate(page: current_page)
      @flux = @user.fluxes.build if current_user?(@user)
      respond_to do |format|
        format.html do
          redirect_to root_url and return unless @user.activated?
        end
        format.json do
          @thumb_count = Flux.where(user_id: @user.id).sum("like_count")
          render :show
          # render json: {success: true, user: @user.as_json(only: [:id, :name, :email]), fluxes: @fluxes}
        end
      end

    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find params[:id]
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      if json_request?
        @user.activate
      else
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
      end

      respond_to do |format|
        format.html do
          redirect_to root_url
        end

        format.json do
          render json: {success: true, description: "Register success!"}
        end
      end
    else
      respond_to do |format|
        format.html do
          render 'new'
        end

        format.json do
          description = "Register unsccess, please try again."
          if !@user.valid?
            description = "Invalid email, name or password."
          end
          render json: {error: true, description: description}
        end
      end

    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    success = false
    description = "Profile update unsuccess"
    if @user.update_attributes user_params
      success = true
      description = "Profile update success!"
    end

    respond_to do |format|
      format.html {
        if success then
          flash[:success] = description
          redirect_to @user
        else
          render 'edit'
        end
      }
      format.json {
        render json: {success: success, description: description}
      }
    end
  end

  def avatar
    avatar = params.permit(:avatar)
    @user.avatar = avatar
    success = @user.save ? true : false

    render json: {success: success}
  end

  def self_information
    @user = current_user
    @success = true
    render :self_information
  end

  def update_information
    @user = current_user
    update_params = params.require(:user)

    update_params.each do |key, value|
      next if !["id", "name", "email", "avatar"].include?(key)
      if User.column_names.include? key
        @user[key] = value
      end
    end

    @success = @user.save ? true : false

    render :self_information
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  # GET token manage page
  def tokens
    @user = current_user
    @tokens = @user.tokens
    render "tokens"
  end

  def create_token
    @user = current_user
    @token = @user.tokens.build(name: Time.zone.now, token: Token.new_token, deviceID: "zaq-xsw-cde-cde")
    if @token.save
      flash[:success] = "Create token successful!"
    else
      flash[:error] = "Create token unsuccessful :("
    end

    redirect_to tokens_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])

    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])

    render 'show_follow'
  end

  def userProfile
    @user = User.find_by(id: params[:id])
    success = !@user.nil?
    render json: {success: success, user: @user}, except: [:password_digest, :reset_digest, :reset_sent_at, :activation_digest, :remember_digest]
  end

  def cats
    @title = "Cats"
    render json: @user.cats
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    def correct_user
      @user = User.find params[:id]
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def current_page
      page = 1
      page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]
    end


  protected

  def json_request?
    request.format.json?
  end


end
