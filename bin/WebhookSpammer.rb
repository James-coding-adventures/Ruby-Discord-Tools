require 'http'

webhook_url = 'WEBHOOK URL HERE!'

discord_token = 'TOKEN HERE!'

message_count = 5  # Change this to send the message however many times

message_content = 'Hello, world!'  # Change this to change the message to a custom one

api_base_url = 'https://discord.com/api/v10'

payload = {
  'content' => message_content
}

message_count.times do
  response = HTTP.headers('Authorization' => "#{discord_token}", 'Content-Type' => 'application/json')
                  .post(webhook_url, json: payload)

  if response.status == 204
    puts "Message sent successfully"
  else
    puts "Failed to send message (Status: #{response.status})"
  end
end