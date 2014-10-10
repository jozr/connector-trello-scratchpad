require 'factor-connector-api'
require 'ruby-trello'

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
      fail "You must specify a board or user ID"
    end
  end

  action 'add_member' do |params|

    card_id = params['card_id']
    member_id = params['member_id']
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

    begin
      card = Trello::Card.find(card_id)
      added_member = card.add_member(member_id)
    rescue
      fail 'Member ID and card ID required'
    end

    action_callback added_member
  end

  action 'remove_member' do |params|

    card_id = params['card_id']
    member_id = params['member_id']
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

    begin
      card = Trello::Card.find(card_id)
      removed_member = card.remove_member(member_id)
    rescue
      fail 'Member ID and card ID required'
    end

    action_callback removed_member
  end
end
