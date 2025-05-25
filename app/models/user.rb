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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :memberships, class_name: "Membership", foreign_key: "user_id", dependent: :destroy
  has_many  :messages, class_name: "Message", foreign_key: "sender_id", dependent: :nullify

  belongs_to :preferred_language, required: true, class_name: "Language", foreign_key: "preferred_language_id"

  has_many :groups, through: :memberships, source: :group
end
