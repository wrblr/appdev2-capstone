# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  messages_count         :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  preferred_language_id  :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Add these if needed:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  # Messaging Associations
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", inverse_of: :sender
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", inverse_of: :recipient

  # Memberships and Groups
  has_many :memberships, class_name: "Membership", foreign_key: "user_id", dependent: :destroy
  has_many :groups, through: :memberships, source: :group
  has_many :created_groups, class_name: "Group", foreign_key: "creator_id"

  # Language Preference
  belongs_to :preferred_language, class_name: "Language", foreign_key: "preferred_language_id", required: true

  # Avatar/Image Attachment
  has_one_attached :image
end
