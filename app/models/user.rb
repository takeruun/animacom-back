# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  mount_uploader :image, ImagesUploader

  validates :name, presence: true
  validates :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :followings_relationships, class_name: 'Follow', dependent: :destroy
  has_many :followers_relationships, class_name: 'Follow', foreign_key: 'follow_id', dependent: :destroy
  has_many :followings, through: :followings_relationships, source: :follow
  has_many :followers, through: :followers_relationships, source: :user
  has_many :pets, dependent: :destroy

  def already_cuted?(post_id)
    reactions.exists?(post_id: post_id, kind: Reaction.kinds[:cute])
  end

  def already_faved?(post_id)
    reactions.exists?(post_id: post_id, kind: Reaction.kinds[:fav])
  end

  def already_gooded?(post_id)
    reactions.exists?(post_id: post_id, kind: Reaction.kinds[:good])
  end

  def already_cooled?(post_id)
    reactions.exists?(post_id: post_id, kind: Reaction.kinds[:cool])
  end

  def follow?(user)
    followings_relationships.where(follow_id: user.id).present?
  end

  def image_path
    ENV['S3_ASSET_HOST'] + image.path
  end
end
