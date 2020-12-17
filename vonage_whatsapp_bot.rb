    # Pour Vonage
    # Vonage WhatsApp Messages Sandbox webhooks
    # r.on "/webhooks/inbound" do
    #   @url = "https://messages-sandbox.nexmo.com/v0.1/messages"
    #
    #   @req_option = options = {
    #     hostname: 'messages-sandbox.nexmo.com',
    #     port: 443,
    #     path: '/v0.1/messages',
    #     method: 'POST',
    #     authorization: {
    #       username: user,
    #       password: password
    #     },
    #     headers: {
    #       'Content-Type': 'application/json',
    #       'Accept': 'application/json'
    #     }
    #   }
    #
    #   @data = JSON.generate({
    #     "from": { "type": "whatsapp", "number": from_number },
    #     "to": { "type": "whatsapp", "number": to_number },
    #     "message": {
    #       "content": {
    #         "type": "text",
    #         "text": "Hi! Your lucky number is "
    #       }
    #     }
    #     })
    #
    #     r.post do
    #       puts r.params.inspect
    #       "Received Webhook successfully"
    #     end
    #   end
    #
    #   r.on "/webhooks/status" do
    #     r.post do
    #       puts r.params.inspect
    #       "Received Webhook successfully"
    #     end
    #   end
    # Pour Vonage