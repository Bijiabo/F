class RemoteNotificationTokensController < ApplicationController
  before_action :set_remote_notification_token, only: [:show, :edit, :update, :destroy]

  # GET /remote_notification_tokens
  # GET /remote_notification_tokens.json
  def index
    @remote_notification_tokens = RemoteNotificationToken.all
  end

  # GET /remote_notification_tokens/1
  # GET /remote_notification_tokens/1.json
  def show
  end

  # GET /remote_notification_tokens/new
  def new
    @remote_notification_token = RemoteNotificationToken.new
  end

  # GET /remote_notification_tokens/1/edit
  def edit
  end

  # POST /remote_notification_tokens
  # POST /remote_notification_tokens.json
  def create
    @remote_notification_token = RemoteNotificationToken.new(remote_notification_token_params)

    respond_to do |format|
      if @remote_notification_token.save
        format.html { redirect_to @remote_notification_token, notice: 'Remote notification token was successfully created.' }
        format.json { render :show, status: :created, location: @remote_notification_token }
      else
        format.html { render :new }
        format.json { render json: @remote_notification_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remote_notification_tokens/1
  # PATCH/PUT /remote_notification_tokens/1.json
  def update
    respond_to do |format|
      if @remote_notification_token.update(remote_notification_token_params)
        format.html { redirect_to @remote_notification_token, notice: 'Remote notification token was successfully updated.' }
        format.json { render :show, status: :ok, location: @remote_notification_token }
      else
        format.html { render :edit }
        format.json { render json: @remote_notification_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remote_notification_tokens/1
  # DELETE /remote_notification_tokens/1.json
  def destroy
    @remote_notification_token.destroy
    respond_to do |format|
      format.html { redirect_to remote_notification_tokens_url, notice: 'Remote notification token was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remote_notification_token
      @remote_notification_token = RemoteNotificationToken.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remote_notification_token_params
      params.require(:remote_notification_token).permit(:token, :user_id, :failed_count)
    end
end
