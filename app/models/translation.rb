class Translation < ApplicationRecord
  belongs_to :message, required: true, class_name: "Message", foreign_key: "message_id"
  belongs_to :language, required: true, class_name: "Language", foreign_key: "language_id"
end
