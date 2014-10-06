require 'factor-connector-api'

Factor::Connector.service 'trello_cards' do
  action 'list' do |params|
    info "Getting list of cards..."

    api_key = params['api_key']

    fail "API Key required" unless api_key

    begin
      list_of_cards = Trello::API.cards.all
    rescue
      fail "Authentication failed"
    end

    # action_callback message: "card has been moved"
    action_callback list_of_cards
  end
end
