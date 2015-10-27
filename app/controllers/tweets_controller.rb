class TweetsController < ApplicationController
  before_action :require_login

  def index
    @tweets = Tweet.all
  end

  def create
    @tweet = Tweet.new tweet_params
    @tweet.user = current_user
    if @tweet.save
      begin
        Pusher.trigger('tweet_channel', 'new_tweet', {
          tweet_id: @tweet.id,
          tweet_name: @tweet.name,
          user_name: @tweet.user.short_name,
          name: @tweet.name,
          user_picture_url: @tweet.user.picture_url
        })
      rescue Pusher::Error => e
        status = e
      end
      render :json => { status: e }
    else
      render :json => { status: 'false' }, :status => 500
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name)
  end

end
