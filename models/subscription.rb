# frozen_string_literal: true

# require 'sequel'
# require 'aasm'

# Pour Sequel
# class Subscription < Sequel::Model
#   include AASM

#   many_to_one :user

# end


# Pour Mongoid
class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include AASM

  belongs_to :user

end