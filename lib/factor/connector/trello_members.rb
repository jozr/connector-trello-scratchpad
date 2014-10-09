require 'factor-connector-api'
require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_AUTH_TOKEN']
end

Factor::Connector.service 'trello_members' do
  action 'find_member' do |params|

    member_id = params['member_id']
    board_id = params['board_id']
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

    if defined? member_id
      action_callback Trello::Member.find(member_id)
    elsif defined? board_id
      Trello::Board.find(board_id)
      action_callback board.members
    else
      fail "You must specify a User ID"
    end
  end
end
