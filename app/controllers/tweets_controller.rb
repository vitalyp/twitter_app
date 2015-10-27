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
        tweet_id = @tweet.id
        tweet_name = @tweet.name
        user_name = @tweet.user.short_name
        name = @tweet.name
        user_picture_url = @tweet.user.picture_url
        Pusher.trigger('tweet_channel', 'new_tweet', {tweet_id: tweet_id,tweet_name: tweet_name,user_name: user_name,name: name,user_picture_url: user_picture_url})
      rescue Pusher::Error => e
        p "___PUSHER ERROR___:"
        p e
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
