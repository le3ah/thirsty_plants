require 'twilio-ruby'

account_sid = ENV['TWILLIO_ACCOUNT_SID']
auth_token = ENV['TWILLIO_AUTH_TOKEN']

MyTwillioClient = Twilio::REST::Client.new account_sid, auth_token
