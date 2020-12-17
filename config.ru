# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)



require "./whatsapp_bot"
require "./api"


# run WhatsappBot.freeze.app


run Rack::Cascade.new [WhatsappBot.freeze.app, Api::API]

# Api::API.compile!
# run Api::API

# run Rack::URLMap.new("/" => Frontend.new, 
#     "/api" => Api.new) 