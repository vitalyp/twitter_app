/*
* Dynamic Objects Constructor
* */
function DOMFactory(cur_user_id) {
  this._cur_user_id = cur_user_id;
}

DOMFactory.prototype.new_tweet = function(tweet_id, tweet_name, user_name, user_picture_url, user_id) {
  new_tweet = (
    "<div data-tweet-id='tweet_id' class='row single-tweet'>"+
      "<div class='col-md-1 tweet-author'>"+
        "<img src='user_picture_url'/>"+
      "</div>"+
      "<div class='col-md-8 tweet-name'>"+
        "<p class='wrote-at'>"+
          "user_name wrote:"+
        "</p>"+
        "tweet_name"+
      "</div>"+
      "<div class='col-md-3 tweet-icons'>"+
        "<div class='row'>"+
          "<div class='col-md-3'><span class='comment js' onclick='tweet_comment(tweet_id)'><i class='fa fa-comment transition' title='Comment tweet'></i></span></div>"+
          "<div class='col-md-3'><span class='star js' data-star-tweet-id='tweet_id' onclick='tweet_toggle_star(tweet_id)'><i class='fa fa-star transition' title='Follow Tweet'></i></span></div>"+
          "<div class='col-md-3' style='text-align:center'><span class='like js' data-like-tweet-id='tweet_id' onclick='tweet_toggle_like(tweet_id)'><i class='fa fa-heart transition' title='Like tweet'></i></span><i class='like-count' data-like-count-tweet-id='tweet_id'>0</i></div>"+
          "<div class='col-md-3'>"+
            (this._cur_user_id == user_id ? "<span class='trash js' title='Delete Tweet' onclick='tweet_trash(tweet_id)'><i class='fa fa-trash-o'></i></span>" : "<span>&nbsp;</span>")+
          "</div>"+
        "</div>"+
      "</div>"+
      "<div class='col-md-12 tweet-comments'>"+
        "<div class='row new-comment'>"+
          "<div class='col-md-10 col-md-offset-1'>"+
            "<div class='input-group input-group-sm'>"+
              "<input class='form-control' maxlength='100' placeholder='new comment..' type='text'/>"+
              "<span class='input-group-btn'>"+
                "<button class='btn btn-default comment-btn' type='button' onclick='post_comment_btn(this)'>Comment</button>"+
              "</span>"+
            "</div>"+
          "</div>"+
        "</div>"+
      "</div>"+
    "</div>").
      replace(/tweet_id/g, tweet_id).
      replace('tweet_name', tweet_name).
      replace('user_name', user_name).
      replace('user_picture_url', user_picture_url);
  return new_tweet;
};

DOMFactory.prototype.new_comment = function(comment_id, tweet_id, comment_name, user_name, user_picture_url, user_id) {
  var new_comment = (
    "<div data-comment-id='comment_id' class='row comment'>"+
      "<div class='col-md-1 comment-author'>"+
        "<img src='user_picture_url'/>"+
    "</div>"+
    "<div class='col-md-8 comment-name'>"+
      "<p class='commented-at'>"+
        "user_name commented:"+
      "</p>"+
      "comment_name"+
    "</div>"+
    "<div class='col-md-3 comment-icons'>"+
      "<div class='row'>"+
        "<div class='col-md-3' style='text-align:center'><span class='like js' title='Like Comment' data-star-comment-id='comment_id' onclick='comment_toggle_like(comment_id)'><i class='fa fa-heart transition'></i><i class='like-count' data-like-count-comment-id='comment_id'>0</i></span></div>"+
        "<div class='col-md-3'>"+
          (this._cur_user_id == user_id ? "<span class='trash js' title='Delete Comment' onclick='comment_trash(comment_id)'><i class='fa fa-trash-o transition'></i></span>" : "<span>&nbsp;</span>")+
        "</div>"+
    "</div>").
      replace(/comment_id/g, comment_id).
      replace('comment_name', comment_name).
      replace('user_name', user_name).
      replace('user_picture_url', user_picture_url);
  return new_comment;
};

