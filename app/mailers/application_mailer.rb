class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEVISE_MAILER_SENDER'] || 'from@example.com'
  layout 'mailer'
end
