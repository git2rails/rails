class Friendship < ActiveRecord::Base
  validates :user_id, :presence=> true, :uniqueness=>{:scope=> :friend_id}
  validates :friend_id, :presence=> true
  validates :user_status, :presence=> true
  validates :friend_status, :presence=> true  
  
  belongs_to  :user
  belongs_to  :friend, :class_name=> "User"
end
