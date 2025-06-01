# == Schema Information
#
# Table name: groups
#
#  id             :bigint           not null, primary key
#  image          :string
#  messages_count :integer
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :bigint
#
# Indexes
#
#  index_groups_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
class Group < ApplicationRecord
  # Associations to users through memberships
  has_many :memberships, class_name: "Membership", foreign_key: "group_id", dependent: :destroy
  has_many :users, through: :memberships, source: :user

  # Group messages
  has_many :messages, class_name: "Message", foreign_key: "group_id", dependent: :nullify

  # Group creator
  belongs_to :creator, class_name: "User"

  # Group image (Active Storage)
  has_one_attached :image
end
