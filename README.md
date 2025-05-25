# rails-8-template
bundle install
rails generate devise:install

rails generate devise user preferred_language_id:integer image:string messages_count:integer

has_many  :memberships, class_name: "Membership", foreign_key: "user_id", dependent: :destroy
has_many  :messages, class_name: "Message", foreign_key: "sender_id", dependent: :nullify
belongs_to :preferred_language, required: true, class_name: "Language", foreign_key: "preferred_language_id"

has_many :groups, through: :memberships, source: :group


rails g scaffold group name:string image:string messages_count:integer

has_many  :memberships, class_name: "Membership", foreign_key: "group_id", dependent: :destroy
has_many  :messages, class_name: "Message", foreign_key: "group_id", dependent: :nullify

has_many :users, through: :memberships, source: :user


rails g scaffold membership group_id:integer user_id:integer

belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
belongs_to :group, required: true, class_name: "Group", foreign_key: "group_id"


rails g scaffold message group_id:integer sender_id:integer audio:string video:string body:text original_language_id:integer

belongs_to :sender, required: true, class_name: "User", foreign_key: "sender_id", counter_cache: true
belongs_to :group, required: true, class_name: "Group", foreign_key: "group_id", counter_cache: true
has_many  :translations, class_name: "Translation", foreign_key: "message_id", dependent: :destroy
belongs_to :original_language, required: true, class_name: "Language", foreign_key: "original_language_id"


rails g scaffold language name:string

has_many  :messages, class_name: "Message", foreign_key: "original_language_id", dependent: :destroy
has_many  :translations, class_name: "Translation", foreign_key: "language_id", dependent: :destroy
has_many  :users, class_name: "User", foreign_key: "preferred_language_id", dependent: :destroy


rails g scaffold translation body:text message_id:integer language_id:integer

belongs_to :message, required: true, class_name: "Message", foreign_key: "message_id"
belongs_to :language, required: true, class_name: "Language", foreign_key: "language_id"
