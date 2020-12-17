# frozen_string_literal: true

module Api
    class API < Grape::API
        
        version 'v1', using: :header, vendor: 'Api'
        format :json
        prefix :api

        get :hello do
            { hello: 'world' }
          end
          
        resource :users do

        end

        resource :posts do
                # r.get 'posts' do
    #   puts Post.all.class
    #   Post.all.to_json
    # end
    
    # r.get 'posts', String do |id|
    #   puts Post.where(id: id).class
    #   puts Post.find(id).class
    #   Post.where(id: id).to_json
      # Post.where(id: id).exists? ? "true" : "false"
    # end
    
    # r.post 'posts' do
    #   Post.create!(title: r.params[:title]).to_json
    # end
    
    # r.get 'env' do
    #   "Variable d'environnement : #{ENV['TWILIO_ACCOUNT_SID']}, rack_env: #{ENV['RACK_ENV']}"
    # end
        end
        
    end
end