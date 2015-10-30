class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDGRID_FORM']
  layout 'mailer'
end
