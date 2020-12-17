# frozen_string_literal: true

require 'securerandom'
# require 'rubygems'
# require 'excon'

REFERENCE_ID = SecureRandom.uuid
REFERENCE_ID = '306e5f34-e6b8-45ec-9ad2-9dca26da3d55'
puts REFERENCE_ID

BASE_URL = "momodeveloper.mtn.comv1_0/apiuser/#{REFERENCE_ID}apikey"

API_KEY = nil

headers = {
    # Request headers
    "X-Reference-Id" => REFERENCE_ID,
    "Content-Type" => 'application/json',
    "Ocp-Apim-Subscription-Key" => '<put-your-primary-subscription-id here>',
}

params = urllib.urlencode({})

body = json.dumps({
  "providerCallbackHost": <your application domain> })

begin
	req = Excon.new('http://geemus.com')
	res = req.post("", :body => 'language=ruby&class=fog',
  :headers => { "Content-Type" => "application/x-www-form-urlencoded" }))

    conn = httplib.HTTPSConnection('ericssonbasicapi2.azure-api.net')
    conn.request("POST", "/v1_0/apiuser?%s" % params, body, headers)
    response = conn.getresponse()
    print(response.status)
    print(response.reason)
    data = response.read()
    print(data)
    conn.close()
rescue Exception => e
    puts "Cet exception de type : #{e.class} a été levé et le contenu du message est : #{e.message}"
end