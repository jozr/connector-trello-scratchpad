require 'spec_helper'

describe 'Member' do
  it 'finds specific member' do

    api_key = ENV['TRELLO_API_KEY']
    auth_token = ENV['TRELLO_AUTH_TOKEN']

    service_instance = service_instance('trello_cards')

    params = {
      'member_id' => member_id,
      'board_id' => board_id }

    service_instance.test_action('findMember', params) do
      expect_info message: 'Initializing connection to Trello.'
      expect_return
    end
  end
end

