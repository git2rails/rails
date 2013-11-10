class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, :class_name=> "User"
  
  scope :sent, -> { where(:sent=> true) }
  scope :received, -> { where(:sent=> false) }
end
