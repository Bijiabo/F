class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  include SessionsHelper
  include TrendsHelper

  # Apple APNs
  # TODO: - need to be completed
  def pushNotification(user_id, alert="New Message!", badge=0)
    certificateFilePath = File.join(Rails.root, "config", "certificate.pem")
    return if !File.exist?(certificateFilePath)

    device_token = RemoteNotificationToken.find_by(user_id: user_id)
    return unless device_token

    if alert.length > 100
      alert = "#{alert[0..100]}..."
    end

    passphrase = "Changeit!"
    gateway = "gateway.sandbox.push.apple.com" # "gateway.push.apple.com"
    pusher = Grocer.pusher(
        certificate: certificateFilePath,      # required
        passphrase:  passphrase,                       # optional
        gateway:     gateway, # optional; See note below.
        port:        2195,                     # optional
        retries:     3                         # optional
    )
    notification = Grocer::Notification.new(
        device_token:      device_token.token, #"24185ab393d8a763ab8f9976bacc39feeac342e92858558927a04dcf0f2140a4",
        alert:             alert,
        badge:             badge,
        category:          "a category",         # optional; used for custom notification actions
        sound:             "siren.aiff",         # optional
        expiry:            Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
        identifier:        1234,                 # optional; must be an integer
        content_available: true                  # optional; any truthy value will set 'content-available' to 1
    )
    pusher.push(notification)
  end


  private

    def username_for_avatar(name)
      Pinyin.t name
    end

    def avatar_for_user(user)
      if user.avatar
        user.avatar.url
      else
        letter_avatar_url_for(letter_avatar_for(username_for_avatar(user.name), 200))
      end
    end

    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location

        error_massage = "Please log in."
        flash[:danger] = error_massage

        if request.format == :html
          redirect_to login_url
        else
          render json: {error: true, description: error_massage}
        end
      end
    end

  protected

    def json_request?
      request.format.json?
    end

end
