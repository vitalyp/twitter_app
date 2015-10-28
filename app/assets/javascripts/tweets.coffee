#
# TWEETs Icons Functions:
window.tweet_trash = (tweet_id) ->
  if confirm('Are you sure you want to delete this Tweet?')
    $.ajax
      url: '/tweets/'+tweet_id
      type: 'DELETE'
      success: (resp) ->
        console.log resp
  return

window.tweet_comment = (tweet_id) ->
  jNewComment = $('.single-tweet[data-tweet-id="ID"] .new-comment'.replace('ID', tweet_id));
  jNewComment.toggle()

window.tweet_toggle_star = (tweet_id) ->
  $.ajax
    url: '/tweets/'+tweet_id+'/star'
    type: 'POST'
    success: (resp) ->
      console.log resp

window.tweet_toggle_like = (tweet_id) ->
  $.ajax
    url: '/tweets/'+tweet_id+'/like'
    type: 'POST'
    success: (resp) ->
      console.log resp

#
# Common interface processing:
$ ->
  $("#post_btn").click ->
    post_name = $("#post_name").val()
    $('#post_name').val("")
    if post_name.length > 100
      alert "post is too long, make it shorter!"
    else
      console.log post_name
      $.ajax
        url: '/tweets'
        type: 'POST'
        data: tweet:
          name: post_name
        success: (resp) ->
          console.log resp

  $('#post_name').keyup (event) ->
    if event.keyCode == 13
      $('#post_btn').click()
    return

