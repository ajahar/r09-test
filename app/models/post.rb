class Post < ActiveRecord::Base
  has_many :comments
  
  validates_presence_of :title, :content
  validates_length_of :content, :minimum => 5, :message => "isn't long enough!"
  validates_length_of :title, :within => 5..50
end
