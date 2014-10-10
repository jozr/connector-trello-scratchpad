require 'factor-connector-api'
require 'ruby-trello'

Factor::Connector.service 'trello_members' do
  action 'find_member' do |params|

    member_id = params['member_id']
    board_id = params['board_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'A member ID or board ID is required' unless member_id || board_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Retrieving member(s) information'
    if defined? member_id
      action_callback Trello::Member.find(member_id)
    elsif defined? board_id
      Trello::Board.find(board_id)
      action_callback board.members
    else
      fail "Failed to retrieve member(s) information"
    end
  end

  action 'add_member' do |params|

    card_id = params['card_id']
    member_id = params['member_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'A card ID is required' unless card_id
    fail 'A member ID is required' unless member_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Adding member to card'
    begin
      card = Trello::Card.find(card_id)
      added_member = card.add_member(member_id)
    rescue
      fail 'Failed to assign card to member'
    end

    action_callback added_member
  end

  action 'remove_member' do |params|

    card_id = params['card_id']
    member_id = params['member_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Removing member from card'
    begin
      card = Trello::Card.find(card_id)
      removed_member = card.remove_member(member_id)
    rescue
      fail 'Failed to remove member from card'
    end

    action_callback removed_member
  end
end
