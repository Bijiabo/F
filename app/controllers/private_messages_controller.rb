class PrivateMessagesController < ApplicationController
  before_action :set_private_message, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /private_messages
  # GET /private_messages.json
  def index
    @private_messages = PrivateMessage.where('to_user_id = ? OR from_user_id = ?', current_user.id, current_user.id).includes([:from_user,:to_user])
    senders = @private_messages.map {|message| message.from_user}
    receivers = @private_messages.map {|message| message.to_user}
    @groups = senders.uniq.delete_if {|x|x==current_user} .map do |sender|
      count = senders.select {|x| x==sender} .count
      receivers.each do |receiver|
        if receiver == sender
          count += 1
          receivers.delete_if {|x|x==receiver}
        end
      end
      latestMessage = @private_messages.order(created_at: :desc).where('to_user_id = ? OR from_user_id = ?', sender.id, sender.id).limit(1).first()
      {user: sender, count: count, latestMessage: latestMessage}
    end

    @groups += receivers.uniq.delete_if {|x|x==current_user} .map do |receiver|
      count = receivers.select {|x|x==receiver} .count
      latestMessage = @private_messages.order(created_at: :desc).where('to_user_id = ? OR from_user_id = ?', receiver.id, receiver.id).limit(1).first()
      {user: receiver, count: count, latestMessage: latestMessage}
    end
  end

  # GET /private_messages/1
  # GET /private_messages/1.json
  def show
  end

  # GET /private_messages/new
  def new
    @private_message = PrivateMessage.new
  end

  # GET /private_messages/1/edit
  def edit
  end

  # POST /private_messages
  # POST /private_messages.json
  def create
    params = private_message_params
    params[:from_user_id] = current_user.id
    @private_message = PrivateMessage.new(params)

    respond_to do |format|
      if @private_message.save
        notification_content = "[私信] #{current_user.name}: #{params[:content]}"
        if notification_content.empty?
          notification_content = "[私信] #{current_user.name}给你发送了一张图片"
        end
        pushNotification params[:to_user_id], notification_content, 1
        format.html { redirect_to @private_message, notice: 'Private message was successfully created.' }
        format.json { render json: {success: true, data: @private_message} }
      else
        format.html { render :new }
        format.json { render json: {success: false, description: 'private message save error.'} }
      end
    end
  end

  # PATCH/PUT /private_messages/1
  # PATCH/PUT /private_messages/1.json
  def update
    respond_to do |format|
      if @private_message.update(private_message_params)
        format.html { redirect_to @private_message, notice: 'Private message was successfully updated.' }
        format.json { render :show, status: :ok, location: @private_message }
      else
        format.html { render :edit }
        format.json { render json: @private_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_messages/1
  # DELETE /private_messages/1.json
  def destroy
    @private_message.destroy
    respond_to do |format|
      format.html { redirect_to private_messages_url, notice: 'Private message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def with_user
    user_id = params[:id]
    @private_messages = PrivateMessage.order(id: :asc).where('to_user_id = ? OR from_user_id = ?', user_id, user_id).includes([:from_user,:to_user])
    render json: @private_messages
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_message
      @private_message = PrivateMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def private_message_params
      params.require(:private_message).permit(:to_user_id, :content, :picture)
    end
end
