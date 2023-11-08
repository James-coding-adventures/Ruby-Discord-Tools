#WORKING AS OF 11/8/2023
require 'http'

token = 'TOKEN HERE!'

user_ids = ['USER ID HERE!', 'USER ID HERE!' ] # ADD MORE USER IDS WITH A "," IF YOU WANT TO ADD MORE THAN 2 PEOPLE AT ONCE :)

def create_group_dm(token, user_ids)
  url = 'https://discord.com/api/v10/users/@me/channels'
  
  headers = {
    'Authorization' => "#{token}",
    'Content-Type' => 'application/json',
  }
  
  payload = {
    'recipients' => user_ids,
  }
  
  response = HTTP.headers(headers).post(url, json: payload)
  
  if response.code == 201
    channel_id = JSON.parse(response.body)['id']
    puts "Group DM created: #{channel_id}"
  else
    puts "#{response.code}, Response body :o : #{response.body}"
  end
end

create_group_dm(token, user_ids)