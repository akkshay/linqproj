class Link < ActiveRecord::Base
	validates :url, presence: true
	validates :points, presence: true
	validates :user_id, presence: true
	validates :title, presence: true
	serialize :receivers
	belongs_to :user
end
