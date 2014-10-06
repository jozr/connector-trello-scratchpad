require 'spec_helper'

describe 'Trello' do
  describe 'Cards' do
    it 'can list cards' do

      api_key = ENV['TRELLO_API_KEY']
      token = ENV['TRELLO_AUTH_TOKEN']

      service_instance = service_instance('trello_cards')

      received_payload = false
      service_instance.callback = proc do |action_response|
        if action_response[:payload]
          received_payload = true
        end
      end

      params = {
        'api_key' => api_key,
        'token' => token,
      }

      service_instance.call_action('list', params) do
        expect_return
        expect_info message: "Getting list of cards..."
      end

      eventually timeout: 10 do
        received_payload
      end
    end
  end
end
