# frozen_string_literal: true

class Post
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :title, type: String
    
end