require 'spec_helper'

describe 'trello_lists' do
  it 'can create a list' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'board_id' => board_id,
      'name' => name
    }

    service_instance.test_action('create', params) do
      expect_info message: 'Initializing connection to Trello.'
      expect_return
    end
  end
end
