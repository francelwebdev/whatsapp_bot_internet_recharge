# frozen_string_literal: true

# require 'sequel'
# require 'logger'


# connect to database
# DB = Sequel.connect('postgres://francel:123456@localhost/whatsapp_bot_development', loggers: [Logger.new($stdout)]) # Uses the postgres adapter

# require 'mongoid'

if ENV['RACK_ENV'] == 'development'
    Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'), :development)
elsif ENV['RACK_ENV'] == 'production'
    Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'), :production)
end