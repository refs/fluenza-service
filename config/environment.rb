# -*- encoding : utf-8 -*-
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => 'app64624380@heroku.com',
    :password => 'yzgcd3ly9897',
    :domain => 'fluenza.io',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}