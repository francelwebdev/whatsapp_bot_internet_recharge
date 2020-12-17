# frozen_string_literal: true

# require 'sequel'
# require 'phonelib'
# require 'aasm'

# Pour Sequel
# class User < Sequel::Model
#   include AASM

#   one_to_many :subscriptions


# phone.country
# :international_prefix=>"00", :national=>"96619073"
# phone = Phonelib.parse('+22996619073')
# Phonelib.valid_for_country? '+22996619073', 'BJ'
# phone.valid_for_country? 'XX'


#   aasm whiny_transitions: false do
#     state :say_welcome_and_ask_how_help, initial: true
#     state :say_choose_isp
#     state :ask_account_number
#     state :fin

#     event :quitter_le_state_say_welcome_and_ask_how_help_pour_le_state_say_choose_isp do
#       transitions from: :say_welcome_and_ask_how_help, to: :say_choose_isp
#     end

#     event :quitter_le_state_say_choose_isp_pour_le_state_ask_account_number do
#       transitions from: :say_choose_isp, to: :ask_account_number
#     end

#     event :de_ask_account_number_a_fin do
#       transitions from: :ask_account_number, to: :fin
#     end
#   end

# end


# Pour Mongoid
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include AASM
  
  field :whatsapp_number, type: String
  field :aasm_state, type: String

  embeds_many :recharges

  
  # has_many :subscriptions
    
  # phone.country
  # :international_prefix=>"00", :national=>"96619073"
  # phone = Phonelib.parse('+22996619073')
  # Phonelib.valid_for_country? '+22996619073', 'BJ'
  # phone.valid_for_country? 'XX'
  
  
  aasm whiny_transitions: false do
    state :say_welcome_and_ask_how_help, initial: true
    state :say_choose_isp
    state :say_choose_an_subscription_offer
    state :ask_account_number
    state :fin
    
    event :quitter_le_state_say_welcome_and_ask_how_help_pour_le_state_say_choose_isp do
      transitions from: :say_welcome_and_ask_how_help, to: :say_choose_isp
    end

    event :quitter_le_state_say_choose_isp_pour_le_state_say_choose_an_subscription_offer do
      transitions from: :say_choose_isp, to: :say_choose_an_subscription_offer
    end
    
    event :quitter_le_state_say_choose_isp_pour_le_state_ask_account_number do
      transitions from: :say_choose_isp, to: :ask_account_number
    end
    
    event :de_ask_account_number_a_fin do
      transitions from: :ask_account_number, to: :fin
    end
  end
  
end