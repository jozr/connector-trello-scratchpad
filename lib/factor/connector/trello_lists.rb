require 'factor-connector-api'
require 'ruby-trello'

Factor::Connector.service 'trello_lists' do
  action 'find_list'

    list_id = params['list_id']
    board_id = params['board_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'List ID or board ID is required' unless list_id || board_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Retrieving list information'
    if defined? list_id
      action_callback Trello::list.find(list_id)
    elsif defined? board_id
      Trello::Board.find(board_id)
      action_callback board.lists
    else
      fail "Failed to retrieve list information"
    end
  end

  action 'create_list' do |params|

    board_id = params['board_id']
    name = params['name']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'Board identification is required' unless board_id
    fail 'A board name is required' unless name

    content = {
      board_id: board_id,
      name: name
    }

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Creating new list'
    begin
      list = Trello::List.create(content)
    rescue
      'Failed to create list'
    end

    action_callback list
  end

  action 'delete_list'

    list_id = params['list_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'List ID is required' unless list_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = ENV['TRELLO_API_KEY']
        config.member_token = ENV['TRELLO_AUTH_TOKEN']
    end
    rescue
      fail 'Authentication invalid'
    end

    info 'Deleting list'
    begin
      Trello::List.find(list_id)
      list.delete
    rescue
      'Failed to delete list'
    end
  end
end
