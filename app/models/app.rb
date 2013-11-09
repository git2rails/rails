class App < ActiveRecord::Base
  serialize :content, JSON
end
