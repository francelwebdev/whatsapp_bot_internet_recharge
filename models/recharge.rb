# frozen_string_literal: true

class Recharge
    include Mongoid::Document
    include Mongoid::Timestamps
    
    # include AASM
    
    field :status, type: String
    field :internet_service_provider, type: String
    # field :aasm_state, type: String

    embedded_in :user

end