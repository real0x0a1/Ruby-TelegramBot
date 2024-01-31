# -*- Author: Ali -*-
# -*- Info: Professional Telegram Bot -*-
# -*- Description: This Telegram bot is designed to provide users with professional information and assistance. It requires users to join a specific channel to access its features. The bot offers a welcome message, help section, and information about its capabilities. -*-
# -*- Version: 1.0 -*-

require 'telegram/bot'
require 'teleglass'

# Replace 'YOUR_API_TOKEN' with your actual bot API token
token = 'YOUR_API_TOKEN'

# Define the channel ID that users need to join
required_channel_id = '@YOUR_CHANNEL'

# Store user IDs who have joined the channel
joined_users = []

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    user_id = message.from.id

    if !joined_users.include?(user_id) && !user_joined_channel?(bot, user_id, required_channel_id)
      ask_to_join_channel(bot, message.chat.id)
    else
      case message.text
      when '/start'
        send_welcome_message(bot, message.chat.id)
      when '/help'
        send_help_message(bot, message.chat.id)
      when '/about'
        send_about_message(bot, message.chat.id)
      else
        send_default_response(bot, message.chat.id)
      end
    end
  end
end

