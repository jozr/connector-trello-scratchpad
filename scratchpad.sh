begin
  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_API_KEY']
    config.member_token = ENV['TRELLO_AUTH_TOKEN']
  end
rescue
  fail 'Authentication invalid'
end

    if defined? member_id
      Trello::Member.find(member_id)
    elsif defined? board_id
      Trello::Board.find(board_id)
      board.members
    else
      fail "You must specify a User ID"
    end

received_payload = false
service_instance.callback = proc do |action_response|
  if action_response[:payload]
    received_payload = true
  end
end


_____________________________________________________

----------BOARD----------

# board = Trello::Board.find('123')

----------MEMBER----------

# member = Trello::Member.find('123')

# board_members = board.members

# card.add_member(member) #two arguments needed

# card.remove_member(member) #two arguments needed

----------LIST----------

lists = board.lists

found_list = Trello::List.find('123')

# new_list = Trello::List.create(board_id: '123', name: 'Foo')

new_list.delete

----------CARD----------

cards = list.cards

member_cards = member.cards

found_card = Trello::Card.find('123')

new_card = Trello::Card.create(list_id: '123')

closed_card = found_card.close

moved_card = card.move_to_list('123')

moved_card.delete
_____________________________________________________
