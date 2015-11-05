class TokensController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  skip_before_action :verify_authenticity_token, only: :request_new_token

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
      token = user.tokens.build(name: token_name, deviceID: token_device_id, token: new_token)

      if token.save
        response = {email: user.email, token: token}
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

end
