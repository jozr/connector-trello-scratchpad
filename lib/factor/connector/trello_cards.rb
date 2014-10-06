require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'trello_cards' do
  action 'list' do |params|
    info 'Getting list of cards'

    api_key = params['api_key']
    token = params['token']

    fail 'API Key required' unless api_key
    fail 'User token required' unless token

    begin
      list_of_cards = Trello::API.cards.all
    rescue
      fail "Authentication failed"
    end

    action_callback list_of_cards
  end
end
