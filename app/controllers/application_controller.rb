class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  include SessionsHelper
  include TrendsHelper

  # Apple APNs
  # TODO: - need to be completed
  def pushNotification
    certificateFilePath = File.join(Rails.root, "config", "user_config.yml")
    return if !File.exist?(certificateFilePath)

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
        device_token:      "fe15a27d5df3c34778defb1f4f3880265cc52c0c047682223be59fb68500a9a2",
        alert:             "Hello from Grocer!",
        badge:             42,
        category:          "a category",         # optional; used for custom notification actions
        sound:             "siren.aiff",         # optional
        expiry:            Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
        identifier:        1234,                 # optional; must be an integer
        content_available: true                  # optional; any truthy value will set 'content-available' to 1
    )
    pusher.push(notification)
  end


  private
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

end
