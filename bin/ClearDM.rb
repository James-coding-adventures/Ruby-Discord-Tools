#WORKING AS OF 11/8/2023
require 'http'

discord_token = 'TOKEN HERE!'

dm_channel_id = 'DM ID HERE' # On the website version it can be found in the URL when inside the DM

api_base_url = 'https://discord.com/api/v10'

messages_url = "#{api_base_url}/channels/#{dm_channel_id}/messages"
messages_response = HTTP.headers('Authorization' => "#{discord_token}").get(messages_url)

if messages_response.status == 200
  messages = JSON.parse(messages_response.to_s)

  messages.each do |message|
    message_id = message['id']
    delete_url = "#{api_base_url}/channels/#{dm_channel_id}/messages/#{message_id}"
    delete_response = HTTP.headers('Authorization' => "#{discord_token}").delete(delete_url)

    if delete_response.status == 204
      puts "Deleted message with ID: #{message_id}"
    else
      puts "Failed to delete message with ID: #{message_id}"
    end
  end
else
  puts "Failed to fetch messages from the DM channel (Channel ID: #{dm_channel_id})"
end