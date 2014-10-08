require 'factor-connector-api'
require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_AUTH_TOKEN']
end

Factor::Connector.service 'trello_lists' do
  action 'create' do |params|

    board_id = params['board_id']
    name = params['name']

    fail 'Board identification is required' unless board_id
    fail 'A board name is required' unless name

    content = {
      board_id: board.id,
      name: name
    }

    info 'Initializing connection to Trello'
    begin
      list = Trello::List.create(content)
    rescue
      fail 'Authentication failed'
    end

    action_callback list
  end
end
