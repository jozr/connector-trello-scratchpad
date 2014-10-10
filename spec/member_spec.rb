require 'spec_helper'

describe 'trello_members' do
  it 'finds specific member' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'member_id' => member_id,
      'board_id' => board_id
    }

    service_instance.test_action('find_member', params) do
      expect_infro message: 'Initializing connection to Trello'
      expect_info message: 'Retrieving member(s) information'
      expect_return
    end
  end

  it 'adds member from a card' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'card_id' =>  card_id,
      'member_id' => member_id
    }

    service_instance.test_action('add_member', params) do
      expect_infro message: 'Initializing connection to Trello'
      expect_info message: 'Adding member to card'
      expect_return
    end
  end

  it 'removes member from a card' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'card_id' =>  card_id,
      'member_id' => member_id
    }

    service_instance.test_action('remove_member', params) do
      expect_infro message: 'Initializing connection to Trello'
      expect_info message: 'Removing member from card'
      expect_return
    end
  end
end

