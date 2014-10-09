require 'factor-connector-api'
require 'trello'


Factor::Connector.service 'trello_cards' do
  action 'list' do |params|


    user_id = params['user']
    list_id = params['list']
    api_key = params['api_key']
    auth_token = params['auth_token']

    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    cards = if user_id
      member = Trello::Member.find(user_id)
      member.cards
    elsif list_id
      list = Trello::List.find(list_id)
      list.cards
    else
      fail "You must specify a User or List ID"
    end

    action_callback cards
  end
end
