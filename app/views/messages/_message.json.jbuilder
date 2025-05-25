json.extract! message, :id, :group_id, :sender_id, :audio, :video, :body, :original_language_id, :created_at, :updated_at
json.url message_url(message, format: :json)
