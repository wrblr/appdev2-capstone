# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  iso_code   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Language < ApplicationRecord
  has_many  :messages, class_name: "Message", foreign_key: "original_language_id", dependent: :destroy
  has_many  :translations, class_name: "Translation", foreign_key: "language_id", dependent: :destroy
  has_many  :users, class_name: "User", foreign_key: "preferred_language_id", dependent: :destroy
end
