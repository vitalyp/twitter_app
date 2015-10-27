# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

  $('.trash').click (e) ->
    if confirm('Are you sure you want to delete this Tweet?')
      tweet_id = $(this).data('tweet_id')
      $.ajax
        url: '/tweets/'+tweet_id
        type: 'DELETE'
        success: (resp) ->
          console.log resp
    return