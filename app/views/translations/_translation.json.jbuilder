json.extract! translation, :id, :body, :message_id, :language_id, :created_at, :updated_at
json.url translation_url(translation, format: :json)
