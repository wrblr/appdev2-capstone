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
#  recipient_id         :integer
#  sender_id            :integer
#
class Message < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: "User", foreign_key: "sender_id", required: true, counter_cache: true
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id", optional: true, counter_cache: true
  belongs_to :group, class_name: "Group", foreign_key: "group_id", optional: true, counter_cache: true
  belongs_to :original_language, class_name: "Language", foreign_key: "original_language_id", required: true

  has_many :translations, class_name: "Translation", foreign_key: "message_id", dependent: :destroy

  # Scope for direct messaging
  scope :between, ->(user1, user2) {
          where(sender: [user1, user2], recipient: [user1, user2])
        }

  # Validation: Must have either a recipient OR a group, but not both
  validate :recipient_or_group_present
  validates :body, presence: true, unless: -> { audio.present? || video.present? }

  private

  def recipient_or_group_present
    if recipient_id.nil? && group_id.nil?
      errors.add(:base, "Message must have a recipient or a group")
    elsif recipient_id.present? && group_id.present?
      errors.add(:base, "Message cannot have both a recipient and a group")
    end
  end
end
