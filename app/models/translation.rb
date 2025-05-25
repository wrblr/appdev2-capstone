# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  language_id :integer
#  message_id  :integer
#
class Translation < ApplicationRecord
  belongs_to :message, required: true, class_name: "Message", foreign_key: "message_id"
  belongs_to :language, required: true, class_name: "Language", foreign_key: "language_id"
end
