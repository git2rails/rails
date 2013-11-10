class AppRanking < ActiveRecord::Base
  belongs_to :app

  scope :top_selling_paid, -> { where(type: "P") }
  scope :top_selling_free, -> { where(type: "F") }
  scope :top_runtime, -> { where(type: "R") }
end
