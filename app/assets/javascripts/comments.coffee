# Comments processing:
#
window.post_comment_btn = (btn) ->
  new_comment_block = $(btn).parents('.new-comment')
  new_comment_input = $(new_comment_block).find('input')
  comment_name = $(new_comment_input).val();

  if comment_name.length > 1000
    alert "comment is too long, make it shorter!"
  else
    $(new_comment_input).val("")
    $(new_comment_block).toggle()
    tweet_id = $(new_comment_block).parents(".single-tweet").data("tweet-id")
    console.log comment_name
  $.ajax
    url: '/comments'
    type: 'POST'
    data: comment:
      name: comment_name
      tweet_id: tweet_id
      success: (resp) ->
        console.log resp

window.comment_trash = (comment_id) ->
  if confirm('Are you sure you want to delete this Comment?')
    $.ajax
      url: '/comments/'+comment_id
      type: 'DELETE'
      success: (resp) ->
        console.log resp
  return


window.comment_toggle_like = (comment_id) ->
  $.ajax
    url: '/comments/'+comment_id+'/like'
    type: 'POST'
    success: (resp) ->
      console.log resp