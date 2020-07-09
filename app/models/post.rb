class Post < ApplicationRecord
	belongs_to :user
	attachment :post_image
	acts_as_taggable
end
