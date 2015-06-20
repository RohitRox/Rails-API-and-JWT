class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates_length_of :content, :minimum => 25

  extend Paginator

end
