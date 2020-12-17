# frozen_string_literal: true

# require 'dotenv'
Dotenv.load
# require 'twilio-ruby'


# put your own credentials here
# account_sid = ENV['TWILIO_ACCOUNT_SID']
# auth_token = ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
