require 'factor-connector-api'
require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_AUTH_TOKEN']
end

Factor::Connector.service 'trello_members' do

end
