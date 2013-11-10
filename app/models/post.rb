class Post < ActiveRecord::Base

  validates :app_id, presence: true
  validates :type, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  has_many :comments
  belongs_to :user
  belongs_to :app

  scope :active, -> {where(visible: true, enabled: true)}
end
