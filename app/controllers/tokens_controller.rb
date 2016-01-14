class TokensController < ApplicationController
  include LetterAvatar::AvatarHelper
  before_action :logged_in_user, only: [:index, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  def index
    @user = current_user
    @tokens = @user.tokens

    if request.format == :json
      userInformation = {name: @user.name, email: @user.email}
      render json: {user: userInformation, tokens: @tokens}
    end
  end

  def destroy
    destroyResult = Token.find(params[:id]).destroy

    if request.format == :json
      render json: {success: destroyResult ? true : false}
    else
      redirect_to tokens_path
    end
  end

  def request_new_token
    user = User.find_by(email: params[:email].downcase)

    response = {error: true, description: "Wrong email or password."}

    if user && user.authenticate(params[:password])
      token_name = params[:deviceName]
      token_device_id = params[:deviceID]
      new_token = Token.new_token

      token = Token.find_by(deviceID: token_device_id, user_id: user.id)

      if token
        token.token = new_token
      else
        token = user.tokens.build(name: token_name, deviceID: token_device_id, token: new_token)
      end

      if token.save
        # set avatar
        avatar = user.avatar
        unless avatar.url
          avatar = letter_avatar_url_for(letter_avatar_for(Pinyin.t(user.name), 200))
        end
        response = {email: user.email,name: user.name, token: token, avatar: avatar}
      elsif !token.valid?
        response[:description] =  "Incomplete information."
        response[:name] = token_name
        response[:deviceID] = token_device_id
      else
        response[:description] = "Token create error, please try again."
      end
    end

    render json: response
  end

  def check_token
    # set avatar
    avatar = @user.avatar
    unless avatar.url
      avatar = letter_avatar_url_for(letter_avatar_for(Pinyin.t(@user.name), 200))
    end

    respond_to do |format|
      format.html do
        render json: {error: true, description: "only for application clients."}
      end

      format.json do
        if current_user
          @user = current_user
          render json: {success: true, user: {id: @user.id, name: @user.name, email: @user.email}, description: "Token check success.", avatar: avatar}
        else
          render json: {error: false, description: "error token."}
        end

      end
    end
  end

  protected

  def json_request?
    request.format.json?
  end

end
