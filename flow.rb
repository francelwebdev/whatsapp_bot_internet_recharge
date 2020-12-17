# frozen_string_literal: true

# require "aasm"

class Flow
    include AASM
    
    aasm whiny_transitions: false do
        state :say_welcome_and_ask_how_help, initial: true
        state :say_choose_isp
        state :ask_account_number
        state :fin
        
        event :quitter_le_state_say_welcome_and_how_help_pour_le_state_say_choose_isp do
            transitions from: :say_welcome_and_ask_how_help, to: :say_choose_isp
        end
        
        event :quitter_le_state_say_choose_isp_pour_le_state_ask_account_number do
            transitions from: :say_choose_isp, to: :ask_account_number
        end
        
        event :quitter_le_state_ask_account_number_pour_le_state_fin do
            transitions from: :ask_account_number, to: :fin
        end

        event :retour do
            transitions from: :ask_account_number, to: :say_choose_isp
        end
    end
    
end

linstance = Flow.new
rsp = nil

if linstance.say_welcome_and_ask_how_help?
    puts "Dans le state : #{ linstance.aasm.current_state }"
    puts <<~SQUIGGLY_HEREDOC
    Je suis Alex, un Chatbot Whatsapp.
    Je peux t'aider a réactiver ton abonnement Internet sans quitter ton bureau.
    Pour ce faire, utilise l'une des options que je te propose ci-dessous (par exemple: 1, 2, 3, ou 4) pour communiquer avec moi.
    Pour commencer, en quoi puis-je t'aidez ?
    
    1 \u{1F449} Réactiver un abonnement Internet.
    SQUIGGLY_HEREDOC
    rsp = gets.chomp
end

if rsp == "1" and linstance.say_welcome_and_ask_how_help?
    linstance.quitter_le_state_say_welcome_and_how_help_pour_le_state_say_choose_isp
    puts "Dans le state : #{ linstance.aasm.current_state }"
    puts <<~SQUIGGLY_HEREDOC
    Ok, choisir le Fournisseur d'Accès Internet (FAI) parmis les fournisseurs ci-dessous :
    
    1 \u{1F449} ISOCEL Télécom.
    SQUIGGLY_HEREDOC
    rsp = gets.chomp
end

if rsp == "1" and linstance.say_choose_isp?
    linstance.quitter_le_state_say_choose_isp_pour_le_state_ask_account_number
    puts "Dans le state : #{ linstance.aasm.current_state }"
    puts <<~SQUIGGLY_HEREDOC
    Ok, saisir tom numero de compte ou saisir # pour retourner en arriere.
    SQUIGGLY_HEREDOC
    rsp = gets.chomp
end

if rsp == "0000" and linstance.ask_account_number?
    linstance.quitter_le_state_ask_account_number_pour_le_state_fin
    puts "Dans le state : #{ linstance.aasm.current_state }"
    puts <<~SQUIGGLY_HEREDOC
    Ok, connexion reactivé avec succes. Terminé
    SQUIGGLY_HEREDOC
end