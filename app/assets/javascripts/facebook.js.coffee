jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

# pass FB_APP_ID from Controller via its View:
window.fbAsyncInit = ->
  FB_APP_ID =  $("meta[name=fb-app-id]").attr("content");
  console.log("FB_APP_ID:" + FB_APP_ID);
  console.log('LALA!')
  FB.init({
      appId      : FB_APP_ID,
      xfbml      : true,
      version    : 'v2.5',
      cookie: true
    });

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/auth/facebook/callback' if response.authResponse

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

# generated by js2coffee 2.1.0
((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = '//connect.facebook.net/en_US/all.js'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'
