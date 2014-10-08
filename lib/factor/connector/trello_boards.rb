require 'factor-connector-api'
require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_AUTH_TOKEN']
end

Factor::Connector.service 'trello_boards' do
  action 'get' do |params|

    board_link_id = params['board_link_id']

    fail 'Board identification is required' unless board_link_id

    info 'Initializing connection to Trello'
    begin
      board = Trello::Board.find(board_link_id)
    rescue
      fail 'Authentication failed'
    end

    action_callback board_link_id
  end
end
