class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :tokens, :create_token]
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
    @user = User.find(params[:id])
    @fluxes = @user.fluxes.paginate(page: params[:page])
    @flux = @user.fluxes.build if current_user?(@user)
        redirect_to root_url and return unless @user.activated?
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
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."

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
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "Profile update success!"
      redirect_to @user
    else
      render 'edit'
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
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


  protected

  def json_request?
    request.format.json?
  end


end
