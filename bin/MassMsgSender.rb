#WORKING AS OF 11/8/2023
require 'http'

discord_token = 'TOKEN HERE!'

server_id = 'SERVER ID HERE!'

message = 'MESSAGE HERE!'

api_base_url = 'https://discord.com/api/v10'

channels_url = "#{api_base_url}/guilds/#{server_id}/channels"
channels_response = HTTP.headers('Authorization' => "#{discord_token}").get(channels_url)

if channels_response.status == 200
  channels = JSON.parse(channels_response.to_s)

  channels.each do |channel|
    next unless channel['type'] == 0

    message_url = "#{api_base_url}/channels/#{channel['id']}/messages"
    message_response = HTTP.headers('Authorization' => "#{discord_token}", 'Content-Type' => 'application/json')
                        .post(message_url, json: { content: message })

    if message_response.status == 200
      puts "Message sent to channel #{channel['name']} (ID: #{channel['id']})"
    else
      puts "Failed to send message to channel #{channel['name']} (ID: #{channel['id']})"
    end
  end
else
  puts "Failed to fetch channels from the server (Server ID: #{server_id})"
end
