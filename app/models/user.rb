class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	acts_as_paranoid

	validates :email, presence: true
  	validates :email, uniqueness: {conditions: ->{with_deleted}}
  	
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :validatable
	has_many :posts, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	attachment :profile_image

	has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
	has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
	has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

	has_many :user_rooms
	has_many :chats
	has_many :rooms, through: :user_rooms

	has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
	has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

	def follow(user_id)
	follower.create(followed_id: user_id)
	end

	# ユーザーのフォローを外す
	def unfollow(user_id)
	follower.find_by(followed_id: user_id).destroy
	end

	# フォローしていればtrueを返す
	def following?(user)
	following_user.include?(user)
	end
	def create_notification_follow!(current_user)
      temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
      if temp.blank?
        notification = current_user.active_notifications.new(
          visited_id: id,
          action: 'follow'
        )
        notification.save if notification.valid?
      end
    end
end
