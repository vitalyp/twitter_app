class TweetsController < ApplicationController
  before_action :require_login

  include ActionView::Helpers::DateHelper
  def index
    @tweets = Tweet.limit(10).order("created_at desc")
  end

  def create
    @tweet = Tweet.new tweet_params
    @tweet.user = current_user
    if @tweet.save
      status = 'true'
      begin
        Pusher.trigger('tweet_channel', 'new_tweet', {
          tweet_id: @tweet.id,
          tweet_name: @tweet.name,
          user_name: @tweet.user.short_name,
          user_picture_url: @tweet.user.picture_url
        })
      rescue Pusher::Error => e
        p e
        status = e
      end
      render :json => { status: status }
    else
      render :json => { status: 'false' }, :status => 500
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet && @tweet.user == current_user
      @tweet.destroy
      status = 'true'
      begin
        Pusher.trigger('tweet_channel', 'destroy_tweet', { tweet_id: params[:id]})
      rescue Pusher::Error => e
        p e
        status = e
      end
      render :json => { status: status }
    else
      render :json => { status: 'false' }, :status => 500
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name)
  end

end
