require 'factor-connector-api'
require 'ruby-trello'


Factor::Connector.service 'trello_cards' do
  action 'list_card' do |params|

    user_id = params['user_id']
    list_id = params['list_id']
    card_id = params['card_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'A list ID, user ID, or card ID is required' unless user_id || list_id || card_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Retrieving card information'
    cards = if user_id
      member = Trello::Member.find(user_id)
      member.cards
    elsif list_id
      list = Trello::List.find(list_id)
      list.cards
    elsif card_id
      Trello::Card.find(card_id)
    else
      fail 'Failed to retrieve card information'
    end

    action_callback cards
  end
  action 'create' do |params|

    list_id = params['list_id']

    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'List identification is required' unless list_id
    fail 'A card name is required' unless name

    content = {
      list_id: list_id,
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

    info 'Creating new card'
    begin
      card = Trello::Card.create(content)
    rescue
      'Failed to create card'
    end

    action_callback card
  end

  action 'move_card' do |params|

    card_id = params['card_id']
    list_id = params['list_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'A card ID is required' unless card_id
    fail 'A list ID is required' unless list_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Moving card to selected list'
    begin
      card = Trello::Card.find(card_id)
      moved_card = card.move_to_list(list_id)
    rescue
      fail 'Failed to move card'
    end

    action_callback moved_card
  end

  action 'close_card' do |params|

    card_id = params['card_id']
    api_key = params['api_key']
    auth_token = params['auth_token']

    fail 'A card ID is required' unless card_id

    info 'Initializing connection to Trello'
    begin
      Trello.configure do |config|
        config.developer_public_key = api_key
        config.member_token = auth_token
      end
    rescue
      fail 'Authentication invalid'
    end

    info 'Closing selected card'
    begin
      card = Trello::Card.find(card_id)
      closed_card = card.close
    rescue
      fail 'Failed to close card'
    end

    action_callback closed_card
  end
end
