require 'spec_helper'

describe 'trello_lists' do
  it 'can find a list'

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'list_id' => list_id,
      'board_id' => board_id
    }

    service_instance.test_action('find_list', params) do
      expect_info message: 'Initializing connection to Trello'
      expect_info message: 'Retrieving list information'
      expect_return
    end
  end

  it 'can create a list' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'board_id' => board_id,
      'name' => name
    }

    service_instance.test_action('create_list', params) do
      expect_info message: 'Initializing connection to Trello'
      expect_info message: 'Creating new list'
      expect_return
    end
  end

  it 'can delete a list'

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = { 'list_id' => list_id }

    service_instance.test_action('delete_list', params) do
      expect_info message: 'Initializing connection to Trello'
      expect_info message: 'Deleting list'
      expect_return
    end
  end
end
