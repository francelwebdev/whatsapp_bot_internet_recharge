# frozen_string_literal: true

class InternetServiceProvider
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String
    # field :number_country, type: String

    index({ name: 1 }, { unique: true })

  end