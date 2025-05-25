# == Schema Information
#
# Table name: messages
#
#  id                   :bigint           not null, primary key
#  audio                :string
#  body                 :text
#  video                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  group_id             :integer
#  original_language_id :integer
#  sender_id            :integer
#
class Message < ApplicationRecord
  
  belongs_to :sender, required: true, class_name: "User", foreign_key: "sender_id", counter_cache: true
  belongs_to :group, required: true, class_name: "Group", foreign_key: "group_id", counter_cache: true
  has_many  :translations, class_name: "Translation", foreign_key: "message_id", dependent: :destroy
  belongs_to :original_language, required: true, class_name: "Language", foreign_key: "original_language_id"

end
