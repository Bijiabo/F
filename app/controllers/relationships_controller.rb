class RelationshipsController < ApplicationController
  before_action :logged_in_user

  skip_before_action :verify_authenticity_token, if: :json_request?

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
      format.json do
        render json: {success: true}
      end
    end
  end

  def destroy
    success = false
    if target_relationship = Relationship.find_by(id: params[:id])
      @user = target_relationship.followed
      current_user.unfollow(@user)
      success = true
    else
      @user = current_user
    end

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
      format.json do
        render json: {success: success}
      end
    end
  end

  def unfollow
    success = false
    if target_relationship = Relationship.find_by(followed_id: params[:id])
      @user = target_relationship.followed
      current_user.unfollow(@user)
      success = true
    else
      @user = current_user
    end

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
      format.json do
        render json: {success: success}
      end
    end
  end

  protected

  def json_request?
    request.format.json?
  end

end
