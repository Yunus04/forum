class ForumThread < ApplicationRecord

	extend FriendlyId

	friendly_id :title, use: :slugged

	belongs_to :user
	has_many :forum_posts, dependent: :destroy

	validates :title, presence: true, length: {maximum: 50}
	validates :content, presence: true

	def sticy?
		sticy_order !=100
		
	end

	def pinit!
		self.sticy_order = 1
		self.save
	end
end
