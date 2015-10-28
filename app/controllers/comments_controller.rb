class CommentsController < ApplicationController
  before_action :require_login

  include ActionView::Helpers::DateHelper

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    if @comment.save
      status = 'true'
      begin
        Pusher.trigger('tweet_channel', 'new_comment', {
            tweet_id: @comment.tweet.id,
            comment_id: @comment.id,
            comment_name: @comment.name,
            user_name: @comment.user.short_name,
            user_picture_url: @comment.user.picture_url,
            user_id: @comment.user.id
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
    @comment = Comment.find(params[:id])
    if @comment && @comment.user == current_user
      @comment.destroy
      status = 'true'
      begin
        Pusher.trigger('tweet_channel', 'destroy_comment', { comment_id: params[:id]})
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

  def comment_params
    params.require(:comment).permit(:tweet_id, :name)
  end

end