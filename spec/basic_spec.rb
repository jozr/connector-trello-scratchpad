require 'spec_helper'

describe 'Trello API' do
  describe 'Board' do
    it 'finds specific board' do

      api_key = ENV['TRELLO_API_KEY']
      auth_token = ENV['TRELLO_AUTH_TOKEN']

      service_instance = service_instance('trello_cards')

      params = { 'board_link_id' => board_link_id }

      service_instance.test_action('findBoard', params) do
        expect_info message: 'Initializing connection to Trello.'
        expect_return
      end
    end
  end

  describe 'List' do
    it 'can create a list' do

      api_key = ENV['TRELLO_API_KEY']
      auth_token = ENV['TRELLO_AUTH_TOKEN']

      service_instance = service_instance('trello_cards')

      params = {
        'board_id' => board_id,
        'name' => name
      }

      service_instance.test_action('createList', params) do
        expect_info message: 'Initializing connection to Trello.'
        expect_return
      end
    end
  end
end
