# frozen_string_literal: true


# require 'roda'
# require 'rack/protection'
require './models'
# require 'twilio-ruby'
# require 'amazing_print'


class WhatsappBot < Roda

  # plugin :render
  
  route do |req|
    # GET / request
    req.root do
      'hello, world'
      # view("home")
    end
    
    # Twilio whatsapp_bot
    # POST /bot request
    req.post 'bot' do
      puts '************************'
      puts ap req.params
      puts '************************'
      body = req.params['Body'].downcase.strip.chomp
      puts '************************'
      
      # Sequel
      # user = User.first(whatsapp_number: r.params['From'])
      
      # Mongoid
      user = User.where(whatsapp_number: req.params['From'])
      
      puts '************************'
      puts ap user
      puts '************************'
      
      # Sequel - !user.nil?
      
      greetings = %i(bonjour bonsoir bjr bsr hello hi cc coucou slt salut)
      # body.start_with?("bonjour", "bonsoir", "bjr", "bsr", "hello", "hi", "cc", "coucou", "slt", "salut")
      # body.end_with?("bonjour", "bonsoir", "bjr", "bsr", "hello", "hi", "cc", "coucou", "slt", "salut")

      rsponse = Twilio::TwiML::MessagingResponse.new
      
      if !user.exists? && greetings.include?(body.to_sym)
        
        User.create!(whatsapp_number: req.params['From'])

        rsponse.message do |message|          
          message.body(Time.now.hour >= 12 ? "Bonsoir," : "Bonjour,")
          message.body(
           <<~SQUIGGLY_HEREDOC
            Je suis Alex, le chatbot Whatsapp de QuickR " service de réactivation de connexion internet à distance".
            At any time, use the menu below to navigate through the features
            Pour traiter au mieux votre demande, entrer simplement l'une des chiffres du menu ci-dessous (par exemple: 1, 2, 3, ou 4).
            En quoi puis-je vous aider ?
            
            1. Réactiver un abonnement Internet.
            2. Souscrire un abonnement Internet.
            3. Résilier mon abonnement Internet.
            4. Ouvrir un ticket d'assistance.
            5. Foires aux questions.
            SQUIGGLY_HEREDOC
          )          
        end
        
      elsif user.exists? && greetings.include?(body.to_sym)
        
        user.update aasm_state: 'say_welcome_and_ask_how_help' if user.aasm_state != 'say_welcome_and_ask_how_help'
        
        rsponse.message do |message|
          message.body(Time.now.hour >= 12 ? "Bonsoir," : "Bonjour,")
          message.body(
            <<~SQUIGGLY_HEREDOC
            Content de vous revoir !
            # To communicate with me, please use any of theses option below to get started.
            En quoi puis-je vous aider ?
            
            1. Réactiver un abonnement Internet.
            2. Souscrire un abonnement Internet.
            3. Résilier mon abonnement Internet.
            4. Ouvrir un ticket d'assistance.
            5. Foires aux questions.
            SQUIGGLY_HEREDOC
          )
        end
        
      elsif user.exists? && body.to_i.is_a?(Integer)
        
        case body.to_i
        when 1
          if user.aasm.current_state == 'say_welcome_and_ask_how_help'
            user.quitter_le_state_say_welcome_and_ask_how_help_pour_le_state_say_choose_isp
            rsponse.message do |message|
              message.body(
                <<~SQUIGGLY_HEREDOC
                Ok, choisissez votre Fournisseur d'Accès Internet parmis les fournisseurs ci-dessous :
                
                1. ISOCEL Télécom.
                2. Bénin Télécom.
                3. OTI Télécom.
                4. Be.
                5. Jeny SAS.
                SQUIGGLY_HEREDOC
              )
            end
            user.update aasm_state: "say_choose_isp"
          elsif user.aasm.current_state == "say_choose_isp"
            user.quitter_le_state_say_choose_isp_pour_le_state_say_choose_an_subscription_offer
            rsponse.message do |message|
              message.body(
                <<~SQUIGGLY_HEREDOC
                Ok, choisissez une offre Internet.
                
                1. ISOLIGHT (25000f, validité 30 jrs, Débit 1Mbps).
                2. ISONET (25000f, validité 30 jrs, Débit 1Mbps).
                3. ISONET+ (25000f, validité 30 jrs, Débit 3Mbps).
                4. ISOPRO (25000f, validité 30 jrs, Débit 3Mbps).
                5. ISOPRO+ (25000f, validité 30 jrs, Débit 3Mbps).
                SQUIGGLY_HEREDOC
              )
            end            
          elsif user.aasm.current_state == "say_choose_isp"
            user.quitter_le_state_say_choose_isp_pour_le_state_ask_account_number
            rsponse.message do |message|
              message.body(
                <<~SQUIGGLY_HEREDOC
                Ok, \u{1F44D}. saisissez les cinq derniers chiffres du numéro de compte client.
                SQUIGGLY_HEREDOC
              )
            end
            user.update aasm_state: "ask_account_number"
          end          
        when 2          
          if user.aasm.current_state == "say_choose_isp"
            rsponse.message do |message|
              message.body(
                <<~SQUIGGLY_HEREDOC
                Ok, entrer les cinq derniers chiffres du numéro de compte client.
                SQUIGGLY_HEREDOC
              )
            end            
            user.quitter_le_state_say_welcome_and_how_help_pour_le_state_say_choose_isp
          elsif user.aasm.current_state == :say_choose_isp
            rsponse.message do |message|
              message.body(
                <<~SQUIGGLY_HEREDOC
                Ok, saisir ton numero du compte client à 5 chiffres.
                SQUIGGLY_HEREDOC
              )
            end
          end          
        when 3
          message.body(
          )
        when 4
          message.body(
            "
            Ok, cliquer sur le liens suivant pour procéder au paiement.
            "
          )
        when 5
          if user.aasm.current_state == "say_choose_isp"
            if user.quitter_le_state_say_welcome_and_ask_how_help_pour_le_state_say_choose_isp
              message.body(
              )
            end
          end
        when 0
          
        else
          message.body(
          )
        end
        
      end
      
      response['Content-Type'] = 'text/xml'
      rsponse.to_xml
      
    end    
    # Twilio whatsapp_bot
    
  end
end
