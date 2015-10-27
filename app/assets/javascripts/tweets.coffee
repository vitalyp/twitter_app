# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#post_btn").click ->
    post_name = $("#post_name").val()
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