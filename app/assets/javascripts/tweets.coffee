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
    tweet_text = $("#tweet_text_input").val()
    $('#tweet_text_input').val("")

    if tweet_text.length > 2800
      alert "post is too long, make it shorter!"
    else
      console.log tweet_text
      $.ajax
        url: '/tweets'
        type: 'POST'
        data: tweet:
          name: tweet_text
        success: (resp) ->
          console.log resp

  $('#tweet_text_input').keyup (event) ->
    #if event.keyCode == 13
    #  $('#post_btn').click()
    return

  $('.tweet-name').emoticonize({delay: 800,animate: true})
  $('.comment-name').emoticonize({delay: 1200,animate: true})
  $('.well').emoticonize()
  $('.btn-emoticons-collapser').emoticonize({delay: 0, animate: false})
  
  $('#collapseEmoticons .animated-emoticon').click ->
    emoticon_code = $(this).text()
    $('#tweet_text_input').append(" " + emoticon_code + " ")
