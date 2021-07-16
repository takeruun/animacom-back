# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :email, presence: true

  has_many :posts
  has_many :reactions

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
end
