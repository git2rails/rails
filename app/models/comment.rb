class Comment < ActiveRecord::Base

  validates :post_id, presence: true  
  validates :comment, presence: true  
  validates :user_id, presence: true  

  belongs_to :post
  belongs_to :user
  

  scope :active, -> { where(visible: true, enabled: true) }
end
