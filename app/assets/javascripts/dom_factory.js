/*
* Dynamic Objects Constructor
* */
function DOMFactory(cur_user_id) {
  this._cur_user_id = cur_user_id;
}

DOMFactory.prototype.new_tweet = function(tweet_id, tweet_name, user_name, user_picture_url, user_id) {
  new_tweet = (
    "<div data-tweet_id='tweet_id' class='row single-tweet'>"+
      "<div class='col-md-1 tweet-author'>"+
        "<img src='user_picture_url'/>"+
        "<div class='name'>user_name</div>"+
      "</div>"+
      "<div class='col-md-7 tweet-name'>"+
        "tweet_name"+
      "</div>"+
      "<div class='col-md-3 tweet-icons'>"+
        "<span class='comment' onclick='tweet_comment(tweet_id)'><i class='fa fa-comment transition'></i></span>"+
        "<span class='star' onclick='tweet_toggle_star(tweet_id)'><i class='fa fa-star transition'></i></span>"+
        "<span class='like' onclick='tweet_toggle_like(tweet_id)'><i class='fa fa-heart transition'></i></span>"+
        (this._cur_user_id == user_id ? "<span class='trash' onclick='tweet_trash(tweet_id)'><i class='fa fa-trash-o'></i></span>" : "<span>&nbsp;</span>")+
        "<br/><div class='timeago' onclick=''>right now</div>"+
      "</div>"+
    "</div>").
      replace('tweet_id', tweet_id).
      replace('tweet_name', tweet_name).
      replace('user_name', user_name).
      replace('user_picture_url', user_picture_url);
  return new_tweet;
};