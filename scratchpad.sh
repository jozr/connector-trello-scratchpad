Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_AUTH_TOKEN']
end

received_payload = false
service_instance.callback = proc do |action_response|
  if action_response[:payload]
    received_payload = true
  end
end


_____________________________________________________

----------BOARD----------

board = Trello::Board.find('123') # url id or standard id

board_members = board.members

----------MEMBER----------

member = Trello::Member.find('123')

member_cards = member.cards

----------LIST----------

lists = board.lists

found_list = Trello::List.find('123')

new_list = Trello::List.create(board_id: '123', name: 'Foo')

new_list.delete

----------CARD----------

cards = list.cards

found_card = Trello::Card.find('123')

new_card = Trello::Card.create(list_id: '123')

closed_card = found_card.close

moved_card = card.move_to_list('123')

moved_card.delete

card.add_member(member) # must be object

card.remove_member(member)
_____________________________________________________
