##How to use:
    git clone git@github.com:vitalyp/twitter_app.git
    bundle
    rake db:migrate #-> may require you local db setup step

##Rake tasks:

    rake db:truncate #-> truncates database


##Twitter is a social networking microblogging service that allows registered members to broadcast short posts called tweets.

>Create a small example of information network made up of 100-character messages called Tweets.

###Functional requirements

- After sign up/in user must land on page with list of new Tweets and list of other followers tweets
- User wants to be able to create/update/delete his own Tweets
- User wants to be able to “Follow” other users
- User wants to be able to add comments to Tweets of other users
- User wants to be able to add “Likes” to Tweets of other users
- User wants to be able to add Tweets of other users to his “favorites”
- User also  wants to be able to add users to his “favorites”
- Favorite tweets and favorite users must be shown in one “favorites” list
- User wants to be able to add his avatar image and manage his profile

###Technical requirements

* It should be WEB application
* For the client side must be used: HTML, CSS (any libs as Twitter Bootstrap, Foundation ...), JavaScript (any libs as jQuery, Backbone ...)
* Client side must be adapted for mobile devices
* For server side - Ruby language, RoR framework, any DB you like…
* It should have client side and server side validation.
* It should have social login(any social network as Facebook or google etc...)
* Project must be deployed on  http://heroku.com

###Additional functionality

- It should work like one page WEB application and should use AJAX technology, load and submit data without reloading a page
- It should have user authentication solution
- It should have automated tests for all functionality


###SQL task

Given tables:

    tweets (id, name, status, user_id)
    users (id, name)

Write the queries for:

- get all statuses, not repeating, alphabetically ordered.
- get the count of all tweets for each user, order by tweets count descending.
- get the count of all tweets for each user, order by users names.
- get the tweets for all users having the name beginning with “N” letter.
- get the list of all users containing the ‘a’ letter in the middle of the name, and show the tweets count .near each project. Mention that there can exist users without tweets and tweets with 'user_id=NULL'
- get the list of tweets with duplicate names. Order alphabetically.
- get the list of tweets having several exact matches of both name and status, from the user ‘Phil’. Order by matches count.
- get the list of users names having more than 10 tweets in status ‘starred’. Order by user_id.

