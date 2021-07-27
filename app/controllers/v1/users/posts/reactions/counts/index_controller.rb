class V1::Users::Posts::Reactions::Counts::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!
  
  def index
    @counts = current_v1_users_user.posts.select('count(posts.id) as count, reactions.kind').joins(:reactions).where(created_at: Time.current.all_day).group('reactions.kind').order('reactions.kind')

    render 'v1/users/posts/reactions/counts/index', formats: :json
  end
end